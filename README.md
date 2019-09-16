# Audiogram

A plotting device for audiogram data.  Receives JSON data and produces
SVG.  There's [example output.](./example.svg).


## Use

``` erlang
SVG = audiogram:audiogram(AudiometricsData).
```

## Format

``` json
{
  "audiograms": [
    {
      "ear": "left",
      "conduction": "air",
      "data": [
        {
          "f": 0.25,
          "m": false,
          "db": 70
        },
        {
          "f": 0.5,
          "m": false,
          "db": 70
        },
        {
          "f": 1,
          "m": false,
          "db": 90
        },
        {
          "f": 2,
          "m": false,
          "db": 80
        },
        {
          "f": 4,
          "m": false,
          "db": 80
        }
      ]
    }
  ]
}

```

Ear may be `left` or `right`.

Conduction may be `air` or `bone`.

Frequency ("f", in Hz) may be any of: .125, .25, .5, .75, 1, 1.5, 2,
3, 4, 6, 8, 12, 16.

Level ("db", in dB) may be in the range of -10 -- 140.

Masked ("m") may be `true` or `false`.  False is the default.




## Author

Bunny Lushington;
September 2019
