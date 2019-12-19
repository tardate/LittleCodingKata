#!/usr/bin/env python
""" A script to build the catalog.json file.

Collates all project metadata into a simple JSON file used by the catalog index.
It also generates a data file used by jekyll page generation.
(These are currently two separate files because of the different
access pattern requirements for each)

This should be re-run after adding a project or updating any project metadata.

"""
from sys import argv
import os
import re
import json
import fnmatch
from datetime import datetime
from xml.etree import ElementTree
from xml.dom import minidom


class Catalog(object):
    """ Helper class for building the catalog from metadata files. """

    def __init__(self):
        path = os.path.dirname(os.path.abspath(__file__))
        self.collection_root = os.path.abspath(os.path.join(path, '..'))
        self.catalog_json = os.path.join(self.collection_root, 'catalog', 'catalog.json')
        self.project_json = os.path.join(self.collection_root, '_data', 'projects.json')
        self.catalog_atom = os.path.join(self.collection_root, 'catalog', 'atom.xml')

    def metadata_files(self):
        """ Returns the collection of catalog metadata files. """
        matches = []
        for root, dirnames, filenames in os.walk(self.collection_root):
            for filename in fnmatch.filter(filenames, '.catalog_metadata'):
                matches.append(os.path.join(root, filename))
        return matches

    def metadata(self):
        """ Returns the metadata based on .catalog_metadata files. """

        def load_data(filename):
            data = json.load(open(filename, 'r'))
            data['updated_at'] = self.get_project_modified_datetime(data['relative_path']).strftime("%Y-%m-%dT%H:%M:%SZ")
            return data

        def add_id(i, data):
            data['id'] = '#' + str(i + 1).zfill(3)
            return data

        if getattr(self, '_metadata', None) is None:
            data = map(lambda filename: load_data(filename), self.metadata_files())
            data = sorted(data, key=lambda k: k['updated_at'])
            self._metadata = map(lambda (i, data): add_id(i, data), enumerate(data))
        return self._metadata

    def get_project_file(self, relative_path, name='.catalog_metadata'):
        return os.path.join(self.collection_root, relative_path, name)

    def get_project_modified_datetime(self, relative_path, filename='.catalog_metadata'):
        indicative_file = self.get_project_file(relative_path, filename)
        return datetime.utcfromtimestamp(os.path.getmtime(indicative_file))

    def generate_catalog(self):
        """ Command: re-writes the catalog file from catalog_metadata. """
        print "Writing {}..".format(self.catalog_json)
        with open(self.catalog_json, 'w') as f:
            json.dump(self.metadata(), f, indent=4)

    def generate_project_data(self):
        def project_data():
            result = {}
            for item in self.metadata():
                result['/{}/'.format(item['relative_path'])] = {
                    "id": int(item['id'].replace('#', '')),
                    "title": item['name'],
                    "summary": item['description'],
                    "tags": item['categories'].split(', ')
                }
            return result

        print "Writing {}..".format(self.project_json)
        with open(self.project_json, 'w') as f:
            json.dump(project_data(), f, indent=4)

    def generate_atom_feed(self):
        """ Command: re-writes the atom feed file from catalog_metadata. """

        def pretty_write(doc, file):
            pretty_xml = minidom.parseString(
                ElementTree.tostring(doc, 'utf-8')
            ).toprettyxml(indent="  ")
            with open(file, 'w') as f:
                f.write(pretty_xml.encode('utf8'))

        print "Writing {}..".format(self.catalog_atom)
        root = ElementTree.Element('feed', xmlns='http://www.w3.org/2005/Atom')
        root.set('xmlns:g', 'http://base.google.com/ns/1.0')
        ElementTree.SubElement(root, "title").text = "LittleCodingKata"
        ElementTree.SubElement(root, "subtitle").text = "my collection of programming exercises, research and code toys broadly spanning things that relate to programming and software development (languages, frameworks and tools)"
        ElementTree.SubElement(root, "link", href="https://codingkata.tardate.com/catalog/atom.xml", rel="self")
        ElementTree.SubElement(root, "link", href="https://codingkata.tardate.com/")
        ElementTree.SubElement(root, "id").text = "https://codingkata.tardate.com/"
        ElementTree.SubElement(root, "updated").text = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ")

        author = ElementTree.SubElement(root, "author")
        ElementTree.SubElement(author, "name").text = "Paul Gallagher"
        ElementTree.SubElement(author, "email").text = "gallagher.paul@gmail.com"
        ElementTree.SubElement(author, "uri").text = "https://github.com/tardate"

        for entry in self.metadata():
            url = 'https://codingkata.tardate.com/{}/'.format(entry['relative_path'])
            # hero_image_file = '{}_build.jpg'.format(entry['relative_path'].split('/')[-1])
            # asset_path = '{}/assets'.format(entry['relative_path'])
            # hero_image_url = 'https://codingkata.tardate.com/{}/{}'.format(
            #     asset_path,
            #     hero_image_file
            # )
            doc = ElementTree.SubElement(root, "entry")
            ElementTree.SubElement(doc, "id").text = url
            ElementTree.SubElement(doc, "link", href=url)
            ElementTree.SubElement(doc, "updated").text = entry['updated_at']
            ElementTree.SubElement(doc, "title").text = entry['name']
            ElementTree.SubElement(doc, "summary").text = entry['description']
            # ElementTree.SubElement(doc, "g:image_link").text = hero_image_url
            for category in entry['categories'].split(', '):
                ElementTree.SubElement(doc, "category", term=category)

        pretty_write(root, self.catalog_atom)

    def rebuild(self):
        """ Command: rebuild catalogcatalog assets from metadata. """
        self.generate_catalog()
        self.generate_project_data()
        self.generate_atom_feed()


if __name__ == '__main__':
    catalog = Catalog()
    operation = argv[1] if len(argv) > 1 else 'rebuild'
    getattr(catalog, operation)()
