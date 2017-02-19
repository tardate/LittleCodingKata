#! /usr/bin/env python
import argparse
import os
from imgurpython import ImgurClient


def get_client():
    client_id = os.environ['CLIENT_ID']
    client_secret = os.environ['CLIENT_SECRET']
    return ImgurClient(client_id, client_secret)


def scan_gallery(client, gallery_id):
    items = client.get_album_images(gallery_id)
    for item in items:
        print(item.link)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Collect images from a gallery")
    parser.add_argument(
        '-g',
        help='gallery ID',
        type=str
    )
    args = parser.parse_args()
    scan_gallery(get_client(), args.g)
