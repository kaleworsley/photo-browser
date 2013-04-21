Photo Browser [![Build Status](https://travis-ci.org/kaleworsley/photo-browser.png?branch=master)](https://travis-ci.org/kaleworsley/photo-browser)
=============

Photo Browser is a simple sinatra app for browsing my photo collection. It's really shit.

Directory Structure
-------------------

This app expects the following directory structure for the photo archive:

    .
    ├── 2012
    │   ├── August
    │   │   ├── 2012-08-02_09-17-59.jpg
    │   │   └── ...
    │   ├── December
    │   │   ├── some_photo.jpg
    │   │   └── ...
    │   └── September
    │       ├── another_photo.jpg
    │       └── no_spaces_in_the_file_name.jpg
    └── 2013
        ├── February
        │   ├── blah.jpg
        │   └── blah2.jpg
        └── January
            ├── blah4.jpg
            └── test.jpg


Thats `/Year/Month/photo.jpg`.

Setup
-----

I've included sample `nginx`, `unicorn` and `init.d` files in the `config` directory.

You'll need to replace `/PATH/TO/APP` with the actual path.

You'll also have to create a symlink in the `public` directory that points to your photos.

Basic setup steps (this is basically what I did on my ubuntu server at home):

```bash
# Clone repo
git clone https://github.com/kaleworsley/photo-browser.git
cd photo-browser

# Copy init.d script
cp config/initd.example /etc/init.d/photo-browser-unicorn
update-rc.d photo-browser-unicorn defaults

# Copy nginx config
cp config/nginx.example /etc/nginx/sites-enabled/photo-browser.lan

# Set the correct app root path, and servername
vim /etc/init.d/photo-browser-unicorn
vim /etc/nginx/sites-enabled/photo-browser.lan

# Symlink photos
ln -s /path/to/photos public/photos

# Install gems
bundle --binstubs

# Restart services
service nginx restart
service photo-browser-unicorn restart
```

TODO
----

- Refactor `PhotoBrowser::Filesystem` to allow different directory structures.
- More specs (feature specs, perhaps)
- Better setup instructions
- Add support for videos

Notes
-----

This project uses:

- [Sinatra](http://www.sinatrarb.com/)
- [Bootstrap](http://getbootstrap.com/)
- [Unicorn](http://unicorn.bogomips.org/)

The init.d script has been stolen from [Rails Casts, episode 293](https://github.com/railscasts/293-nginx-unicorn/blob/master/todo-after/config/unicorn_init.sh).
License
-------

Copyright 2013, Kale Worsley.

Photo Browser made available under the MIT License. See [LICENSE.txt](LICENSE.txt) for details.

