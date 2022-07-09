
### Plasma 5 way:

```sh
kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta ""
```

### Manual way:

1. `vim ~/.config/kwinrc`
2. Add:
```
[ModifierOnlyShortcuts]
Meta=
```
