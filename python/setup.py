#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""The setup script."""

from setuptools import setup, find_packages

with open('README.rst') as readme_file:
    readme = readme_file.read()

with open('HISTORY.rst') as history_file:
    history = history_file.read()

requirements = [
    'Click>=6.0',
    'redis',
    'python-dotenv',
    'beautifulsoup4',
    ]

setup_requirements = [ ]

test_requirements = [ ]

setup(
    author="Kenji Fujiwara",
    author_email='niyaton@gmail.com',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Natural Language :: English',
        "Programming Language :: Python :: 2",
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
    ],
    description="Library for Hubot",
    entry_points={
        'console_scripts': [
            'sdlab-graduates=sdlab.cli:main',
            'dump-brain=sdlab.cli:dump_brain',
            'restore-brain=sdlab.cli:restore_brain',
            'clean-brain=sdlab.cli:clean_brain'
        ],
    },
    install_requires=requirements,
    license="MIT license",
    long_description=readme + '\n\n' + history,
    include_package_data=True,
    keywords='sdlab',
    name='sdlab',
    packages=find_packages(include=['sdlab']),
    setup_requires=setup_requirements,
    test_suite='tests',
    tests_require=test_requirements,
    url='https://github.com/niyaton/sdlab',
    version='0.0.1',
    zip_safe=False,
)
