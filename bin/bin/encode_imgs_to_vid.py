#!/usr/bin/env python
from itertools import product
import argparse
import math
import multiprocessing
import time

from sh import ffmpeg


DEFAULT_FRAME_RATE = 25
DEFAULT_OUTPUT_FNAME = 'output_%s_%dfps.mp4' % (time.strftime("%H%M%S"), DEFAULT_FRAME_RATE)


def process_output(line):
    print line,


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Encode still images to a video using FFmpeg.'
            , formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('img_files', type=str, nargs='*', default=['%04d.png'],
            help='a pattern of input image files')
    parser.add_argument('-o', '--output_file', type=str, default=DEFAULT_OUTPUT_FNAME,
            nargs='?', help='an output file', metavar='O')
    parser.add_argument('-vs', '--vertical_sxs', dest='horizontal_sxs',
            action='store_false', help='create a vertical side by side video')
    parser.add_argument('-f', '--frame_rate', type=int, default=DEFAULT_FRAME_RATE,
            help='frame rate', metavar='R')
    parser.add_argument('-t', '--threads', type=int,
            default=multiprocessing.cpu_count() // 2 + 1,
            help='the number of threads to use', metavar='N')
    parser.add_argument('-b', '--baseline', action="store_true",
                        help='use the Baseline Profile for better compatibility')
    parser.add_argument('-p', '--p1080', action="store_true", help='scale to 1080p')
    args = parser.parse_args()

    # Build FFmpeg options
    opts = []

    # Input files
    """
    If the sequence pattern contains "%d" or "%0Nd", the first filename of the file
    list specified by the pattern must contain a number inclusively contained
    between start_number and start_number+start_number_range-1, and all the
    following numbers must be sequential.

    'start_number'
    Set the index of the file matched by the image file pattern to start to read
    from. Default value is 0.

    'start_number_range'
    Set the index interval range to check when looking for the first image file in
    the sequence, starting from start_number. Default value is 5.
    """
    opts += ['-start_number_range', 100]

    for img_file in args.img_files:
        if any([glob_char in img_file for glob_char in '*?[]']):
            opts += ['-pattern_type', 'glob']  # 'sequence'
            print 'Use glob() file pattern for %s...' % img_file
            break

    for f in args.img_files:
        opts += ['-i', f]

    # Merge options (Overlay)
    n_img_files = len(args.img_files)
    if n_img_files > 1:
        # By default, place input videos in horizontal direction.
        n_row, n_col = 1, n_img_files
        if n_img_files == int(math.sqrt(n_img_files)) ** 2:
            # If n_img_files is a perfect square, switch to grid layout.
            n_row = n_col = int(math.sqrt(n_img_files))
        row_col_indices = product(range(n_row), range(n_col));  # fix row, inc. col

        # Place input videos in vertical direction.
        if not args.horizontal_sxs:
            row_col_indices = [(c, r) for r, c in row_col_indices]  # inc. row, fix col
            n_row, n_col = n_col, n_row

        pad = '[0:0]pad=iw*%(n_col)d:ih*%(n_row)d'
        overlay = '[a];[a][%(src_idx)d:0]overlay=w*%(col_idx)d:h*%(row_idx)d'

        f = ''
        for src_idx, (row_idx, col_idx) in enumerate(row_col_indices):
            if src_idx == 0:
                f = pad % {'n_row': n_row, 'n_col': n_col}
            else:
                f += overlay % {'src_idx': src_idx, 'row_idx': row_idx,
                        'col_idx': col_idx}
        if args.p1080:
            f += '[a];[a]scale=-1:1080'  # Scale to 1080p
        opts += ['-filter_complex', f]

    # Video options
    opts += ['-y',
             '-r', args.frame_rate,
             '-vcodec', 'libx264',
             '-threads', args.threads,
             '-preset', 'veryslow',
             #'-crf', '18',  # Original setting
             '-crf', '6',  # High-quality setting
             '-pix_fmt', 'yuv420p',  # for QuickTime
             #'-bf', '0', '-g', '1',  # Frame-by-frame scrubbing
             #'-movflags', '+faststart'  # faststart for Web video
             ]

    if args.baseline:
        opts += ['-profile:v', 'baseline', '-level', '3.0']  # for iMovie and so on
    else:
        opts += ['-profile:v', 'high', '-level', '4.2']  # iPad >= Air, iPhone >= 5S

    # Output file
    opts.append(args.output_file)

    try:
        print
        p = ffmpeg(*opts, _out=process_output, _err_to_out=True, _piped=True)
        print 'Command:', p.ran
        print
        p.wait()
    except KeyboardInterrupt:
        print 'Ctrl-C pressed.'
        p.kill()
    exit(p.exit_code)
