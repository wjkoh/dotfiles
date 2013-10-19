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
    parser.add_argument('-t', '--threads', type=int, default=multiprocessing.cpu_count() // 2,
                        help='the number of threads to use', metavar='N')
    args = parser.parse_args()

    # Build FFmpeg options
    opts = []

    # Input files
    for f in args.img_files:
        opts += ['-i', f]

    # Merge options (Overlay)
    if len(args.img_files) == 2:
        if args.horizontal_sxs:
            opts += ['-filter_complex', '[0:0]pad=iw*2:ih[a];[a][0:1]overlay=w:0']
        else:
            opts += ['-filter_complex', '[0:0]pad=iw:ih*2[a];[a][1:0]overlay=0:h']

    # Video options
    opts += ['-y',
            '-r', args.frame_rate,
            '-vcodec', 'libx264',
            '-threads', args.threads,
            '-preset', 'slow',
            '-crf', '1',
            '-profile:v', 'baseline',  # for iMovie
            '-pix_fmt', 'yuv420p']
    #opts += ['-s', '1442x852']  # Output dimension

    # Output file
    opts.append(args.output_file)

    p = sh.ffmpeg(*opts,
                _out=process_output,
                _err=process_output,
                _out_bufsize=1,
                _err_bufsize=1)
    p.wait()
