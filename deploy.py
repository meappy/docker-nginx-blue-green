#!/usr/bin/python
  
__author__ = ['[Gerald Sim](https://github.com/meappy)']
__date__ = '2019.05.29'
__version__ = "1.0.2"

"""
Set and print blue green deployment
"""

from ConfigParser import SafeConfigParser
import argparse
import sys
import os

sys.dont_write_bytecode = True

parser = argparse.ArgumentParser()

parser.add_argument('-c', '--config', type=str,
                    action="store", dest="config",
                    default="config.ini",
                    help="specify location of config file, defaults to config.ini")

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

# Print -h if no args supplied, needs to be before parser.parse_args()
if len(sys.argv) < 2:
    parser.print_usage()
    sys.exit(1)

args = parser.parse_args()

config_file = args.config
config_file_exists = os.path.isfile(config_file)

if not config_file_exists:
    print('Config file not found or not defined, see -h for help')
    quit()

# Parse config_file
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

if args.deploy:
    deploy_bg(args.deploy)
    print_deploy_status()
elif args.print_:
    print_deploy_status()
