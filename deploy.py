#!/usr/bin/python
  
__author__ = ['[Gerald Sim](https://github.com/meappy)']
__date__ = '2019.05.24'

"""
Set and print blue green deployment
"""

from ConfigParser import SafeConfigParser
import argparse
import sys

sys.dont_write_bytecode = True

parser = argparse.ArgumentParser()

parser.add_argument('-d', '--deploy', type=str,
                    action="store", dest="deploy",
                    choices=['blue','green'],
                    help="deploy <blue|green>")

parser.add_argument('-p', '--print',
                    action="store_true", dest='print_',
                    help="print deploy status")

parser.add_argument('-q', '--quiet',
                    action="store_true", dest='quiet',
                    help="suppress output")

config_file = 'config.ini'
config = SafeConfigParser()
config.read(config_file)
upstream_file = config.get('config', 'upstream')

def deploy_bg(args):
    with open(upstream_file, 'w') as upstream:
        upstream.write(config.get('deploy', args))

def print_deploy_status():
    with open(upstream_file) as upstream:
        upstream = upstream.readline()

    if args.quiet:
        pass
    else:
        print 'Current deploy status: %s' % (upstream).rstrip()

# Print -h if no args supplied, needs to be before parser.parse_args()
if len(sys.argv) < 2:
    parser.print_usage()
    sys.exit(1)

args = parser.parse_args()

if args.deploy:
    deploy_bg(args.deploy)
    print_deploy_status()
elif args.print_:
    print_deploy_status()
