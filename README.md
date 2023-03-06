# $HOME configuration

My [Home Manager](https://nix-community.github.io/home-manager/) configuration, very much inspired by [Tidying up your $HOME with Nix](https://juliu.is/tidying-your-home-with-nix/).

## Installation

- [Install Nix](https://nixos.org/download.html)
- [Enable flakes](https://nixos.wiki/wiki/Flakes#Enable_flakes)
- Clone this repository into `~/.config/nixpkgs`
- Run `nix run . switch` in that directory

## Making changes

- Edit `home.nix` and run `home-manager switch`

**Useful references**

- [Home Manager configuration options](https://nix-community.github.io/home-manager/options.html)
- [Source for Home Manager packages](https://github.com/nix-community/home-manager/tree/master/modules/programs)

## Future work

- There are several cases where I could be using `programs.*` with the built-in options rather than using `home.packages` along with `home.file.*`, which would likely yield a better-integrated setup.
