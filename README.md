# Phalcon Composer Action

GitHub Actions for [Composer](https://getcomposer.org) in [Phalcon]() projects. Base on Docker official [PHP](https://hub.docker.com/_/php) image, and installed [hirak/prestissimo](https://github.com/hirak/prestissimo) package.

## Usage

Via GitHub Workflow

```
action "Phalcon Composer Install" {
  uses = "bvelastegui/phalcon-composer-action@master"
  args = "install"
}
```

## Credits

* [MilesChou](https://github.com/MilesChou) _(original repository)_
* [Bryan Velastegui](https://github.com/bvelastegui)

## License

The MIT License (MIT). Please see [License File](LICENSE) for more information.
