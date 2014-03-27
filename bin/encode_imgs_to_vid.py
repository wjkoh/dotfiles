#!/usr/bin/env python
import argparse
import multiprocessing
import time
from sh import ffmpeg


DEFAULT_FRAME_RATE = 25
DEFAULT_OUTPUT_FNAME = 'output_%s_%dfps.mp4' % (time.strftime("%H%M%S"), DEFAULT_FRAME_RATE)


def process_output(line):
    print line,


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Encode still images to a video using FFmpeg.',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('img_files', type=str, nargs='*',
                        default=['%04d.png'], help='a pattern of input image files')
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
        pad = '[0:0]pad=iw*%d:ih'
        overlay = '[a];[a][0:%d]overlay=w*%d:0'
        if not args.horizontal_sxs:
            pad = '[0:0]pad=iw:ih*%d'
            overlay = '[a];[a][%d:0]overlay=0:h*%d'

        f = pad % n_img_files
        for i in range(1, n_img_files):
            f += overlay % (i, i)
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
        opts += ['-profile:v', 'high', '-level', '4.1']  # iPad >= 2, iPhone >= 4S

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
