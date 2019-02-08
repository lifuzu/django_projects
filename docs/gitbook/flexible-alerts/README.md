# Introduce flexible alerts
https://www.npmjs.com/package/gitbook-plugin-flexible-alerts

### Setting up in book.json
```
{
  "plugins": [
    "flexible-alerts"
  ],
  "pluginsConfig": {
    "flexible-alerts": {
      "style": "flat",
      "note": {
        "label": {
          "de": "Hinweis",
          "en": "Note"
        }
      },
      "tip": {
        "label": {
          "de": "Tipp",
          "en": "Tip"
        }
      },
      "warning": {
        "label": {
          "de": "Warnung",
          "en": "Warning"
        }
      },
      "danger": {
        "label": {
          "de": "Achtung",
          "en": "Attention"
        }
      },
      "comment": {
        "label": "Comment",
        "icon": "fa fa-comments",
        "className": "info"
      }
    }
  }
}
```

### Install the plugin
```
$ gitbook install
# then
$ gitbook build
# OR
$ gitbook serve
```

### Examples

An example to display NOTE
> [!NOTE]
> An alert of type 'note' using global style 'flat'.

Display NOTE but callout style
> [!NOTE|style:callout]
> An alert of type 'note' using alert specific style 'callout' which overrides global style 'flat'.

Display TIP with custom label
> [!TIP|style:flat|label:My own heading|iconVisibility:false]
> An alert of type 'tip' using alert specific style 'flat' which overrides global style 'callout'.
> In addition, this alert uses an own heading and hides specific icon.

Display custom type `COMMENT`
> [!COMMENT]
> An alert of type 'comment' using style 'callout' with default settings.
