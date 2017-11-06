# Gisc

Gisc, short for Generic Image Signature Checker, is a generic image signature checker to validate if an image is of the type that is being loaded. Allows for making sure an image is a valid gif, jpeg or png.

Currently theonly supported image types are:

- jpg
- png
- gif

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  Gisc:
    github: exts/Gisc
```

## Usage

```crystal
require "Gisc"

imginfo = Gist::Checker.new "path/to/image.png"
if imginfo.check "png"
  puts "this is a valid png"
  puts imginfo.signature
  #puts imginfo.image.get() #read Gisc/Image.cr for more info
end
```

## Contributing

1. Fork it ( https://github.com/exts/Gisc/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [exts](https://github.com/exts) exts - creator, maintainer
