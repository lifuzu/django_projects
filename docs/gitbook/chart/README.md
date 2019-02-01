# Introduce C3.js or Highcharts chart library
https://github.com/csbun/gitbook-plugin-chart

### Setting up mermaid in book.json
```
{
  "plugins": [ "chart" ],
  "pluginsConfig": {
      "chart": {
          "type": "c3"
      }
  }
}
```
`type` can be `c3` or `highcharts`, default to `c3`.


### Example for C3.js

{% chart %}
{
    "data": {
        "type": "bar",
        "columns": [
            ["data1", 30, 200, 100, 400, 150, 1500, 2500],
            ["data2", 50, 100, 300, 450, 650, 250, 1320]
        ]
    },
    "axis": {
        "y": {
            "tick": {
                "format": d3.format("$,")
            }
        }
    }
}
{% endchart %}


### Example for C3.js in YAML

{% chart format="yaml" %}
data:
    type: bar
    columns:
        - [data1, 30, 200, 100, 400, 150, 250]
        - [data2, 50, 20, 10, 40, 15, 25]
    axes:
        data2: y2
axis:
    y2:
        show: true
{% endchart %}

