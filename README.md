# Audiogram

A plotting device for audiogram data.  Receives JSON data and produces SVG.


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

Frequency ("f", in Hz) may be any of:

  * .125
  * .25
  * .5
  * .75
  * 1
  * 1.5
  * 2
  * 3
  * 4
  * 6
  * 8
  * 12
  * 16

Level ("db", in dB) may be in the range of -10 -- 140.

Masked ("m") may be `true` or `false`.  False is the default.

## Example Output

<svg width="660" height="480">
  <style>
   text.axis-label {
       font-size: larger;
       font-family: sans-serif;
       text-anchor: middle;
   }
   text.y-label-tick {
       font-family: monospace;
       text-anchor: end;
       dominant-baseline: middle;
   }
   line.y-label-tick {stroke: #eee;}
   line.y-axis {stroke: black;}

   
   text.x-label-tick {
       font-family: monospace;
       text-anchor: middle;
   }
   line.y-label-tick {stroke: #eee;}
   line.x-axis {stroke: black;}

   line.x-label-minor-tick {
       stroke: #ccc;
       stroke-dasharray: 2,5;
   }
   text.x-label-minor-tick {
       font-family: monospace;
       font-size: smaller;
       text-anchor: middle;
   }
  </style>
  
  <defs>
    <g id="major-graph">
      <!-- xaxis (and -10 db) -->
      <text x="-100" y="0" class="axis-label"
          transform="rotate(-90, 70, 50)">Level (dB)</text>`
      
      <line x1="80" y1="400" x2="640" y2="400" class="y-axis" />
      <text x="60" y="400" class="y-label-tick">-10</text>
      
      <!-- 0 db -->
      <line x1="80" y1="375" x2="640" y2="375" class="y-label-tick" />
      <text x="60" y="375" class="y-label-tick">0</text>
      
      <!-- 10 db -->
      <line x1="80" y1="350" x2="640" y2="350" class="y-label-tick" />
      <text x="60" y="350" class="y-label-tick">10</text>
      
      <!-- 20 db -->
      <line x1="80" y1="325" x2="640" y2="325" class="y-label-tick" />
      <text x="60" y="325" class="y-label-tick">20</text>
      
      <!-- 30 db -->
      <line x1="80" y1="300" x2="640" y2="300" class="y-label-tick" />
      <text x="60" y="300" class="y-label-tick">30</text>
      
      <!-- 40 db -->
      <line x1="80" y1="275" x2="640" y2="275" class="y-label-tick" />
      <text x="60" y="275" class="y-label-tick">40</text>
      
      <!-- 50 db -->
      <line x1="80" y1="250" x2="640" y2="250" class="y-label-tick" />
      <text x="60" y="250" class="y-label-tick">50</text>
      
      <!-- 60 db -->
      <line x1="80" y1="225" x2="640" y2="225" class="y-label-tick" />
      <text x="60" y="225" class="y-label-tick">60</text>
      
      <!-- 70 db -->
      <line x1="80" y1="200" x2="640" y2="200" class="y-label-tick" />
      <text x="60" y="200" class="y-label-tick">70</text>
      
      <!-- 80 db -->
      <line x1="80" y1="175" x2="640" y2="175" class="y-label-tick" />
      <text x="60" y="175" class="y-label-tick">80</text>
      
      <!-- 90 db -->
      <line x1="80" y1="150" x2="640" y2="150" class="y-label-tick" />
      <text x="60" y="150" class="y-label-tick">90</text>
      
      <!-- 100 db -->
      <line x1="80" y1="125" x2="640" y2="125" class="y-label-tick" />
      <text x="60" y="125" class="y-label-tick">100</text>
      
      <!-- 110 db -->
      <line x1="80" y1="100" x2="640" y2="100" class="y-label-tick" />
      <text x="60" y="100" class="y-label-tick">110</text>
      
      <!-- 120 db -->
      <line x1="80" y1="75" x2="640" y2="75" class="y-label-tick" />
      <text x="60" y="75" class="y-label-tick">120</text>
      
      <!-- 130 db -->
      <line x1="80" y1="50" x2="640" y2="50" class="y-label-tick" />
      <text x="60" y="50" class="y-label-tick">130</text>
      
      <!-- 140 db -->
      <line x1="80" y1="25" x2="640" y2="25" class="y-label-tick" />
      <text x="60" y="25" class="y-label-tick">140</text>

      
      <!-- yaxis (and .125 hz) -->
      <text x="360" y="460" class="axis-label">Frequency (Hz)</text>
      
      <line x1="80" y1="400" x2="80" y2="0" class="x-axis" />
      <text x="80" y="430" class="x-label-tick">.125</text>
      
      <!-- .25 -->
      <line x1="160" y1="400" x2="160" y2="0" stroke="#ccc" />
      <text x="160" y="430" class="x-label-tick">.25</text>

      <!-- .5 -->
      <line x1="240" y1="400" x2="240" y2="0" stroke="#ccc" />
      <text x="240" y="430" class="x-label-tick">.5</text>
      
      <!-- 1 -->
      <line x1="320" y1="400" x2="320" y2="0" stroke="#ccc" />
      <text x="320" y="430" class="x-label-tick">1</text>

      <!-- 2 -->
      <line x1="400" y1="400" x2="400" y2="0" stroke="#ccc" />
      <text x="400" y="430" class="x-label-tick">2</text>

      <!-- 4 -->
      <line x1="480" y1="400" x2="480" y2="0" stroke="#ccc" />
      <text x="480" y="430" class="x-label-tick">4</text>

      <!-- 8 -->
      <line x1="560" y1="400" x2="560" y2="0" stroke="#ccc" />
      <text x="560" y="430" class="x-label-tick">8</text>

      <!-- 16 -->
      <line x1="640" y1="400" x2="640" y2="0" stroke="#ccc" />
      <text x="640" y="430" class="x-label-tick">16</text>
    </g>

    <g id="minor-graph">
      <!-- .75 -->
      <line x1="280" y1="400" x2="280" y2="0" class="x-label-minor-tick" />
      <text x="280" y="420" class="x-label-minor-tick">.75</text>
      
      <!-- 1.5 -->
      <line x1="360" y1="400" x2="360" y2="0" class="x-label-minor-tick" />
      <text x="360" y="420" class="x-label-minor-tick">1.5</text>

      <!-- 3 -->
      <line x1="440" y1="400" x2="440" y2="0" class="x-label-minor-tick" />
      <text x="440" y="420" class="x-label-minor-tick">3</text>

      <!-- 6 -->
      <line x1="520" y1="400" x2="520" y2="0" class="x-label-minor-tick" />
      <text x="520" y="420" class="x-label-minor-tick">6</text>

      <!-- 12 -->
      <line x1="600" y1="400" x2="600" y2="0" class="x-label-minor-tick" />
      <text x="600" y="420" class="x-label-minor-tick">12</text>
    </g>
  </defs>

  
  <use xlink:href="#major-graph" />
  <use xlink:href="#minor-graph" />

  <style>
   text.mark {dominant-baseline: middle; text-anchor: middle;}
   text.left {fill: blue;}
   line.left {stroke: blue;}
   text.right {fill: red;}
   line.right {stroke: red;}
  </style>

  <text x="240" y="225" class="mark left">&#8848</text><line x1="315" y1="225" x2="245" y2="225" class="left" /><text x="320" y="225" class="mark left">&#8848</text><line x1="395" y1="200" x2="325" y2="225" class="left" /><text x="400" y="200" class="mark left">&#8848</text><line x1="475" y1="200" x2="405" y2="200" class="left" /><text x="480" y="200" class="mark left">&#8848</text><text x="160" y="150" class="mark right">&#9675</text><line x1="235" y1="150" x2="165" y2="150" class="right" /><text x="240" y="150" class="mark right">&#9675</text><line x1="315" y1="150" x2="245" y2="150" class="right" /><text x="320" y="150" class="mark right">&#9675</text><line x1="395" y1="175" x2="325" y2="150" class="right" /><text x="400" y="175" class="mark right">&#9675</text><line x1="475" y1="125" x2="405" y2="175" class="right" /><text x="480" y="125" class="mark right">&#9675</text><line x1="555" y1="125" x2="485" y2="125" class="right" /><text x="560" y="125" class="mark right">&#9675</text><text x="160" y="200" class="mark left">&#10005</text><line x1="235" y1="200" x2="165" y2="200" class="left" /><text x="240" y="200" class="mark left">&#10005</text><line x1="315" y1="150" x2="245" y2="200" class="left" /><text x="320" y="150" class="mark left">&#10005</text><line x1="395" y1="175" x2="325" y2="150" class="left" /><text x="400" y="175" class="mark left">&#10005</text><line x1="475" y1="163" x2="405" y2="175" class="left" /><text x="480" y="163" class="mark left">&#10005</text>

</svg>


## Author

Bunny Lushington
September 2019
