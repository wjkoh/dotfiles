#!/usr/bin/env python

import argparse
import multiprocessing
import time

import sh

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
             '-crf', '18',
             '-pix_fmt', 'yuv420p',  # for QuickTime
             #'-bf', '0', '-g', '1',  # Frame-by-frame scrubbing
             '-movflags', '+faststart'  # faststart for Web video
             ]
    if args.baseline:
        opts += ['-profile:v', 'baseline', '-level', '3.0']  # for iMovie and so on
    else:
        opts += ['-profile:v', 'high', '-level', '4.1']  # iPad >= 2, iPhone >= 4S

    # Output file
    opts.append(args.output_file)

    p = sh.ffmpeg(*opts,
                _out=process_output,
                _err=process_output,
                _out_bufsize=1,
                _err_bufsize=1)
    print 'Run:', p.ran
    p.wait()
    exit(p.exit_code)
