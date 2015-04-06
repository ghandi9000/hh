
```r
knit_hooks$set(webgl = hook_webgl)
```


```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
## 
## -------------------------------------------------------------------------
## You have loaded plyr after dplyr - this is likely to cause problems.
## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
## library(plyr); library(dplyr)
## -------------------------------------------------------------------------
## 
## Attaching package: 'plyr'
## 
## The following objects are masked from 'package:dplyr':
## 
##     arrange, count, desc, failwith, id, mutate, rename, summarise,
##     summarize
## 
## Loading required package: stats4
## 
## Attaching package: 'bbmle'
## 
## The following object is masked from 'package:dplyr':
## 
##     slice
```

## HH fits
Gompertz:
$H = \beta*e^{log(\frac{\gamma}{\beta})e^{-\alpha DBH}}$

Power:
$H = \gamma + \beta DBH^{\alpha}$

AIC values for gompertz and power fits.

```r
abbas %>%
  arrange(Year, AICc)
```

```
##    Species    Model Vars Year      AIC     AICc
## 1     abba gompertz full   11 3493.371 3493.544
## 2     abba gompertz  can   11 3535.667 3535.724
## 3     abba    power full   11 3669.007 3669.180
## 4     abba    power  can   11 3687.107 3687.165
## 5     abba gompertz elev   11 3991.454 3991.512
## 6     abba    power elev   11 4091.451 4091.509
## 7     abba gompertz  dbh   11 4225.567 4225.590
## 8     abba    power  dbh   11 4296.168 4296.191
## 9     abba gompertz full   99 2435.336 2435.493
## 10    abba gompertz  can   99 2477.695 2477.747
## 11    abba    power full   99 2554.684 2554.841
## 12    abba    power  can   99 2583.376 2583.429
## 13    abba gompertz elev   99 2699.827 2699.879
## 14    abba    power elev   99 2752.833 2752.885
## 15    abba gompertz  dbh   99 2849.991 2850.012
## 16    abba    power  dbh   99 2896.460 2896.480
```

```r
becos %>%
  arrange(Year, AICc)
```

```
##    Species    Model Vars Year      AIC     AICc
## 1     beco    power  can   11 181.7212 182.6889
## 2     beco gompertz  can   11 181.7626 182.7304
## 3     beco    power full   11 183.1585 186.2620
## 4     beco gompertz full   11 183.6089 186.7124
## 5     beco gompertz elev   11 197.6273 198.5950
## 6     beco    power elev   11 199.9791 200.9469
## 7     beco    power  dbh   11 208.4758 208.8508
## 8     beco gompertz  dbh   11 209.4287 209.8037
## 9     beco gompertz full   99 193.7564 196.0348
## 10    beco gompertz  can   99 196.6804 197.4033
## 11    beco gompertz elev   99 197.3289 198.0518
## 12    beco    power full   99 195.7950 198.0735
## 13    beco    power  can   99 201.3613 202.0842
## 14    beco gompertz  dbh   99 214.2361 214.5185
## 15    beco    power  dbh   99 216.1982 216.4805
## 16    beco    power elev   99 426.6271 427.3500
```


# Gompertz models with canopy height only (the current version used for height prediction).
## BECO fits:

```
## Warning in par3d(userMatrix = structure(c(1, 0, 0, 0, 0,
## 0.342020143325668, : font family "sans" not found, using "bitmap"
```

<script src="CanvasMatrix.js" type="text/javascript"></script>
<canvas id="unnamed_chunk_3textureCanvas" style="display: none;" width="256" height="256">
Your browser does not support the HTML5 canvas element.</canvas>
<!-- ****** points object 7 ****** -->
<script id="unnamed_chunk_3vshader7" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
gl_PointSize = 3.;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader7" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** text object 9 ****** -->
<script id="unnamed_chunk_3vshader9" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_3fshader9" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** text object 10 ****** -->
<script id="unnamed_chunk_3vshader10" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_3fshader10" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** text object 11 ****** -->
<script id="unnamed_chunk_3vshader11" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_3fshader11" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** text object 12 ****** -->
<script id="unnamed_chunk_3vshader12" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_3fshader12" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** points object 13 ****** -->
<script id="unnamed_chunk_3vshader13" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
gl_PointSize = 3.;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader13" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 16 ****** -->
<script id="unnamed_chunk_3vshader16" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader16" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 17 ****** -->
<script id="unnamed_chunk_3vshader17" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader17" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 18 ****** -->
<script id="unnamed_chunk_3vshader18" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader18" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 19 ****** -->
<script id="unnamed_chunk_3vshader19" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader19" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 20 ****** -->
<script id="unnamed_chunk_3vshader20" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader20" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 21 ****** -->
<script id="unnamed_chunk_3vshader21" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader21" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 22 ****** -->
<script id="unnamed_chunk_3vshader22" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader22" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 23 ****** -->
<script id="unnamed_chunk_3vshader23" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader23" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 24 ****** -->
<script id="unnamed_chunk_3vshader24" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader24" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 25 ****** -->
<script id="unnamed_chunk_3vshader25" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader25" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 26 ****** -->
<script id="unnamed_chunk_3vshader26" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader26" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 27 ****** -->
<script id="unnamed_chunk_3vshader27" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader27" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 28 ****** -->
<script id="unnamed_chunk_3vshader28" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader28" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 29 ****** -->
<script id="unnamed_chunk_3vshader29" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader29" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 30 ****** -->
<script id="unnamed_chunk_3vshader30" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader30" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 31 ****** -->
<script id="unnamed_chunk_3vshader31" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader31" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 32 ****** -->
<script id="unnamed_chunk_3vshader32" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader32" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 33 ****** -->
<script id="unnamed_chunk_3vshader33" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader33" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 34 ****** -->
<script id="unnamed_chunk_3vshader34" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader34" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 35 ****** -->
<script id="unnamed_chunk_3vshader35" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader35" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 36 ****** -->
<script id="unnamed_chunk_3vshader36" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader36" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 37 ****** -->
<script id="unnamed_chunk_3vshader37" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader37" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 38 ****** -->
<script id="unnamed_chunk_3vshader38" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader38" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 39 ****** -->
<script id="unnamed_chunk_3vshader39" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader39" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 40 ****** -->
<script id="unnamed_chunk_3vshader40" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader40" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 41 ****** -->
<script id="unnamed_chunk_3vshader41" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader41" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 42 ****** -->
<script id="unnamed_chunk_3vshader42" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader42" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** points object 43 ****** -->
<script id="unnamed_chunk_3vshader43" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
gl_PointSize = 3.;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader43" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** points object 44 ****** -->
<script id="unnamed_chunk_3vshader44" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
gl_PointSize = 3.;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader44" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** lines object 45 ****** -->
<script id="unnamed_chunk_3vshader45" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader45" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** text object 46 ****** -->
<script id="unnamed_chunk_3vshader46" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_3fshader46" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** lines object 47 ****** -->
<script id="unnamed_chunk_3vshader47" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader47" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** text object 48 ****** -->
<script id="unnamed_chunk_3vshader48" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_3fshader48" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** lines object 49 ****** -->
<script id="unnamed_chunk_3vshader49" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader49" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** text object 50 ****** -->
<script id="unnamed_chunk_3vshader50" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_3fshader50" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** lines object 51 ****** -->
<script id="unnamed_chunk_3vshader51" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_3fshader51" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<script type="text/javascript">
function getShader ( gl, id ){
var shaderScript = document.getElementById ( id );
var str = "";
var k = shaderScript.firstChild;
while ( k ){
if ( k.nodeType == 3 ) str += k.textContent;
k = k.nextSibling;
}
var shader;
if ( shaderScript.type == "x-shader/x-fragment" )
shader = gl.createShader ( gl.FRAGMENT_SHADER );
else if ( shaderScript.type == "x-shader/x-vertex" )
shader = gl.createShader(gl.VERTEX_SHADER);
else return null;
gl.shaderSource(shader, str);
gl.compileShader(shader);
if (gl.getShaderParameter(shader, gl.COMPILE_STATUS) == 0)
alert(gl.getShaderInfoLog(shader));
return shader;
}
var min = Math.min;
var max = Math.max;
var sqrt = Math.sqrt;
var sin = Math.sin;
var acos = Math.acos;
var tan = Math.tan;
var SQRT2 = Math.SQRT2;
var PI = Math.PI;
var log = Math.log;
var exp = Math.exp;
function unnamed_chunk_3webGLStart() {
var debug = function(msg) {
document.getElementById("unnamed_chunk_3debug").innerHTML = msg;
}
debug("");
var canvas = document.getElementById("unnamed_chunk_3canvas");
if (!window.WebGLRenderingContext){
debug(" Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var gl;
try {
// Try to grab the standard context. If it fails, fallback to experimental.
gl = canvas.getContext("webgl") 
|| canvas.getContext("experimental-webgl");
}
catch(e) {}
if ( !gl ) {
debug(" Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var width = 505;  var height = 505;
canvas.width = width;   canvas.height = height;
var prMatrix = new CanvasMatrix4();
var mvMatrix = new CanvasMatrix4();
var normMatrix = new CanvasMatrix4();
var saveMat = new Object();
var distance;
var posLoc = 0;
var colLoc = 1;
var zoom = new Object();
var fov = new Object();
var userMatrix = new Object();
var activeSubscene = 1;
zoom[1] = 1;
fov[1] = 30;
userMatrix[1] = new CanvasMatrix4();
userMatrix[1].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
function getPowerOfTwo(value) {
var pow = 1;
while(pow<value) {
pow *= 2;
}
return pow;
}
function handleLoadedTexture(texture, textureCanvas) {
gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
gl.bindTexture(gl.TEXTURE_2D, texture);
gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
gl.generateMipmap(gl.TEXTURE_2D);
gl.bindTexture(gl.TEXTURE_2D, null);
}
function loadImageToTexture(filename, texture) {   
var canvas = document.getElementById("unnamed_chunk_3textureCanvas");
var ctx = canvas.getContext("2d");
var image = new Image();
image.onload = function() {
var w = image.width;
var h = image.height;
var canvasX = getPowerOfTwo(w);
var canvasY = getPowerOfTwo(h);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.imageSmoothingEnabled = true;
ctx.drawImage(image, 0, 0, canvasX, canvasY);
handleLoadedTexture(texture, canvas);
drawScene();
}
image.src = filename;
}  	   
function drawTextToCanvas(text, cex) {
var canvasX, canvasY;
var textX, textY;
var textHeight = 20 * cex;
var textColour = "white";
var fontFamily = "Arial";
var backgroundColour = "rgba(0,0,0,0)";
var canvas = document.getElementById("unnamed_chunk_3textureCanvas");
var ctx = canvas.getContext("2d");
ctx.font = textHeight+"px "+fontFamily;
canvasX = 1;
var widths = [];
for (var i = 0; i < text.length; i++)  {
widths[i] = ctx.measureText(text[i]).width;
canvasX = (widths[i] > canvasX) ? widths[i] : canvasX;
}	  
canvasX = getPowerOfTwo(canvasX);
var offset = 2*textHeight; // offset to first baseline
var skip = 2*textHeight;   // skip between baselines	  
canvasY = getPowerOfTwo(offset + text.length*skip);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.fillStyle = backgroundColour;
ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
ctx.fillStyle = textColour;
ctx.textAlign = "left";
ctx.textBaseline = "alphabetic";
ctx.font = textHeight+"px "+fontFamily;
for(var i = 0; i < text.length; i++) {
textY = i*skip + offset;
ctx.fillText(text[i], 0,  textY);
}
return {canvasX:canvasX, canvasY:canvasY,
widths:widths, textHeight:textHeight,
offset:offset, skip:skip};
}
// ****** points object 7 ******
var prog7  = gl.createProgram();
gl.attachShader(prog7, getShader( gl, "unnamed_chunk_3vshader7" ));
gl.attachShader(prog7, getShader( gl, "unnamed_chunk_3fshader7" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog7, 0, "aPos");
gl.bindAttribLocation(prog7, 1, "aCol");
gl.linkProgram(prog7);
var v=new Float32Array([
3.6, 1239, 3.649134,
3.4, 1239, 3.572102,
3.5, 1239, 3.611336,
8.4, 1239, 4.415753,
4, 1239, 3.786657,
4.9, 1239, 4.026116,
4.5, 1239, 3.93055,
5.1, 1239, 4.068162,
5.3, 1239, 4.106743,
3.17, 1269, 3.476233,
5.7, 1269, 4.174508,
3.76, 1269, 3.706707,
3.19, 1269, 3.484888,
5.6, 1269, 4.158667,
9.1, 1269, 4.442518,
6.7, 1299, 4.299407,
8, 1329, 4.396008,
10.2, 1329, 4.470187,
8.4, 1240, 5.451635,
5.5, 1240, 4.602916,
6.3, 1240, 4.897421,
5.9, 1240, 4.756649,
5.2, 1240, 4.478784,
7.9, 1240, 5.344696,
6.7, 1240, 5.025879,
4.9, 1240, 4.346884,
6, 1240, 4.793033,
4.8, 1240, 4.30117,
4.1, 1240, 3.956565,
5.2, 1240, 4.478784,
3.36, 1271, 3.448656,
4.6, 1271, 4.116608,
3.8, 1271, 3.69777,
6.3, 1271, 4.847748,
3.28, 1271, 3.402068,
6.8, 1271, 5.022307,
3.2, 1271, 3.355106,
8.2, 1271, 5.423883,
5.5, 1271, 4.530815,
6.1, 1271, 4.772942,
6.3, 1271, 4.847748,
3.45, 1271, 3.500608,
9.5, 1271, 5.69888,
9, 1271, 5.602884,
4, 1271, 3.806762,
6, 1271, 4.734445,
6.9, 1271, 5.055142,
3.9, 1271, 3.75261,
3.44, 1271, 3.49486,
7.2, 1271, 5.149637,
4.2, 1271, 3.912951,
8.1, 1271, 5.399112,
7.8, 1271, 5.321373,
5.7, 1302, 3.641932,
5.1, 1302, 3.580989,
6.6, 1302, 3.703475,
4.4, 1302, 3.480934,
5.2, 1302, 3.592534,
4.4, 1302, 3.480934,
5.2, 1302, 3.592534,
5.2, 1302, 3.592534,
4.2, 1302, 3.445105,
4.3, 1302, 3.463472,
4.8, 1302, 3.542498,
3.9, 1302, 3.384145,
5.1, 1302, 3.580989,
6.9, 1261, 5.085711,
9.5, 1261, 5.642829,
2.3, 1321, 3.075121,
3.75, 1321, 3.843965,
2.14, 1321, 2.971726,
6.1, 1321, 4.531985,
2.3, 1400, 2.99499,
4.7, 1400, 3.845196,
3.1, 1400, 3.371071,
4.8, 1400, 3.865274,
5.4, 1400, 3.96819,
3.4, 1400, 3.485536,
4.4, 1400, 3.779237,
4.3, 1400, 3.755218,
3.58, 1400, 3.547899,
3.1, 1400, 3.371071,
3.5, 1400, 3.520746,
2.8, 1400, 3.242577,
3.2, 1400, 3.410737,
2.95, 1249, 3.120963,
3.4, 1305, 3.485536,
2.8, 1335, 3.381119,
12.2, 1205, 5.76592
]);
var buf7 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf7);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc7 = gl.getUniformLocation(prog7,"mvMatrix");
var prMatLoc7 = gl.getUniformLocation(prog7,"prMatrix");
// ****** text object 9 ******
var prog9  = gl.createProgram();
gl.attachShader(prog9, getShader( gl, "unnamed_chunk_3vshader9" ));
gl.attachShader(prog9, getShader( gl, "unnamed_chunk_3fshader9" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog9, 0, "aPos");
gl.bindAttribLocation(prog9, 1, "aCol");
gl.linkProgram(prog9);
var texts = [
"gompertz allometric model predictions (,can) for beco"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX9 = texinfo.canvasX;
var canvasY9 = texinfo.canvasY;
var ofsLoc9 = gl.getAttribLocation(prog9, "aOfs");
var texture9 = gl.createTexture();
var texLoc9 = gl.getAttribLocation(prog9, "aTexcoord");
var sampler9 = gl.getUniformLocation(prog9,"uSampler");
handleLoadedTexture(texture9, document.getElementById("unnamed_chunk_3textureCanvas"));
var v=new Float32Array([
7.17, 1433.052, 6.239536, 0, -0.5, 0.5, 0.5,
7.17, 1433.052, 6.239536, 1, -0.5, 0.5, 0.5,
7.17, 1433.052, 6.239536, 1, 1.5, 0.5, 0.5,
7.17, 1433.052, 6.239536, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<1; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
var buf9 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf9);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf9 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf9);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc9 = gl.getUniformLocation(prog9,"mvMatrix");
var prMatLoc9 = gl.getUniformLocation(prog9,"prMatrix");
var textScaleLoc9 = gl.getUniformLocation(prog9,"textScale");
// ****** text object 10 ******
var prog10  = gl.createProgram();
gl.attachShader(prog10, getShader( gl, "unnamed_chunk_3vshader10" ));
gl.attachShader(prog10, getShader( gl, "unnamed_chunk_3fshader10" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog10, 0, "aPos");
gl.bindAttribLocation(prog10, 1, "aCol");
gl.linkProgram(prog10);
var texts = [
"DBH"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX10 = texinfo.canvasX;
var canvasY10 = texinfo.canvasY;
var ofsLoc10 = gl.getAttribLocation(prog10, "aOfs");
var texture10 = gl.createTexture();
var texLoc10 = gl.getAttribLocation(prog10, "aTexcoord");
var sampler10 = gl.getUniformLocation(prog10,"uSampler");
handleLoadedTexture(texture10, document.getElementById("unnamed_chunk_3textureCanvas"));
var v=new Float32Array([
7.17, 1171.948, 2.49811, 0, -0.5, 0.5, 0.5,
7.17, 1171.948, 2.49811, 1, -0.5, 0.5, 0.5,
7.17, 1171.948, 2.49811, 1, 1.5, 0.5, 0.5,
7.17, 1171.948, 2.49811, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<1; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
var buf10 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf10);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf10 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf10);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc10 = gl.getUniformLocation(prog10,"mvMatrix");
var prMatLoc10 = gl.getUniformLocation(prog10,"prMatrix");
var textScaleLoc10 = gl.getUniformLocation(prog10,"textScale");
// ****** text object 11 ******
var prog11  = gl.createProgram();
gl.attachShader(prog11, getShader( gl, "unnamed_chunk_3vshader11" ));
gl.attachShader(prog11, getShader( gl, "unnamed_chunk_3fshader11" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog11, 0, "aPos");
gl.bindAttribLocation(prog11, 1, "aCol");
gl.linkProgram(prog11);
var texts = [
"Elevation"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX11 = texinfo.canvasX;
var canvasY11 = texinfo.canvasY;
var ofsLoc11 = gl.getAttribLocation(prog11, "aOfs");
var texture11 = gl.createTexture();
var texLoc11 = gl.getAttribLocation(prog11, "aTexcoord");
var sampler11 = gl.getUniformLocation(prog11,"uSampler");
handleLoadedTexture(texture11, document.getElementById("unnamed_chunk_3textureCanvas"));
var v=new Float32Array([
0.4348302, 1302.5, 2.49811, 0, -0.5, 0.5, 0.5,
0.4348302, 1302.5, 2.49811, 1, -0.5, 0.5, 0.5,
0.4348302, 1302.5, 2.49811, 1, 1.5, 0.5, 0.5,
0.4348302, 1302.5, 2.49811, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<1; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
var buf11 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf11);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf11 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf11);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc11 = gl.getUniformLocation(prog11,"mvMatrix");
var prMatLoc11 = gl.getUniformLocation(prog11,"prMatrix");
var textScaleLoc11 = gl.getUniformLocation(prog11,"textScale");
// ****** text object 12 ******
var prog12  = gl.createProgram();
gl.attachShader(prog12, getShader( gl, "unnamed_chunk_3vshader12" ));
gl.attachShader(prog12, getShader( gl, "unnamed_chunk_3fshader12" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog12, 0, "aPos");
gl.bindAttribLocation(prog12, 1, "aCol");
gl.linkProgram(prog12);
var texts = [
"Height"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX12 = texinfo.canvasX;
var canvasY12 = texinfo.canvasY;
var ofsLoc12 = gl.getAttribLocation(prog12, "aOfs");
var texture12 = gl.createTexture();
var texLoc12 = gl.getAttribLocation(prog12, "aTexcoord");
var sampler12 = gl.getUniformLocation(prog12,"uSampler");
handleLoadedTexture(texture12, document.getElementById("unnamed_chunk_3textureCanvas"));
var v=new Float32Array([
0.4348302, 1171.948, 4.368823, 0, -0.5, 0.5, 0.5,
0.4348302, 1171.948, 4.368823, 1, -0.5, 0.5, 0.5,
0.4348302, 1171.948, 4.368823, 1, 1.5, 0.5, 0.5,
0.4348302, 1171.948, 4.368823, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<1; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
var buf12 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf12);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf12 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf12);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc12 = gl.getUniformLocation(prog12,"mvMatrix");
var prMatLoc12 = gl.getUniformLocation(prog12,"prMatrix");
var textScaleLoc12 = gl.getUniformLocation(prog12,"textScale");
// ****** points object 13 ******
var prog13  = gl.createProgram();
gl.attachShader(prog13, getShader( gl, "unnamed_chunk_3vshader13" ));
gl.attachShader(prog13, getShader( gl, "unnamed_chunk_3fshader13" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog13, 0, "aPos");
gl.bindAttribLocation(prog13, 1, "aCol");
gl.linkProgram(prog13);
var v=new Float32Array([
4, 1239, 3.838423,
3.5, 1239, 3.536311,
4.1, 1239, 3.89745,
8.6, 1239, 5.914951,
4.8, 1239, 4.295594,
5.8, 1239, 4.81295,
5.2, 1239, 4.510177,
6.2, 1239, 5.001634,
6.1, 1239, 4.955461,
4.7, 1269, 4.108032,
3.8, 1269, 3.622901,
7.5, 1269, 5.293279,
9.2, 1269, 5.779596,
9, 1299, 5.408599,
10.5, 1329, 5.046459,
9.4, 1240, 7.270352,
5.9, 1240, 5.42419,
6.7, 1240, 5.9171,
5.4, 1240, 5.096859,
8.8, 1240, 7.011361,
6.9, 1240, 6.033986,
5, 1240, 4.825513,
6.4, 1240, 5.736932,
4.8, 1240, 4.687016,
5.8, 1240, 5.359848,
7.3, 1271, 5.819971,
7.2, 1271, 5.774502,
8.5, 1271, 6.314054,
7.2, 1271, 5.774502,
10.1, 1271, 6.835217,
9.2, 1271, 6.560258,
6.5, 1271, 5.437294,
7.1, 1271, 5.728359,
7.3, 1271, 5.819971,
8.6, 1271, 6.351054,
7.8, 1271, 6.037283,
7.7, 1302, 4.140562,
5.8, 1302, 3.722933,
5.7, 1302, 3.696057,
6.2, 1302, 3.825231,
6.4, 1302, 3.873337,
4.3, 1302, 3.262232,
5, 1302, 3.492798,
5.4, 1302, 3.612223,
6.3, 1302, 3.849533,
4.6, 1302, 3.364438,
5.8, 1231, 4.81295,
7.9, 1261, 6.218953,
11.2, 1261, 7.329019,
3.5, 1321, 3.451745,
6.7, 1321, 5.006139,
11, 1321, 6.142027,
6.7, 1321, 5.006139,
3.4, 1400, 3.422236,
5, 1400, 4.30952,
3.1, 1400, 3.242196,
3.9, 1400, 3.713988,
3.2, 1400, 3.302574,
3.8, 1400, 3.656565,
6, 1400, 4.786018,
6.1, 1400, 4.830065,
6, 1400, 4.786018,
5.2, 1400, 4.409996,
5, 1400, 4.30952,
8.7, 1400, 5.752475,
3.7, 1400, 3.59866,
3.5, 1335, 3.710984,
14, 1205, 9.721482
]);
var buf13 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf13);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc13 = gl.getUniformLocation(prog13,"mvMatrix");
var prMatLoc13 = gl.getUniformLocation(prog13,"prMatrix");
// ****** linestrip object 16 ******
var prog16  = gl.createProgram();
gl.attachShader(prog16, getShader( gl, "unnamed_chunk_3vshader16" ));
gl.attachShader(prog16, getShader( gl, "unnamed_chunk_3fshader16" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog16, 0, "aPos");
gl.bindAttribLocation(prog16, 1, "aCol");
gl.linkProgram(prog16);
var v=new Float32Array([
0, 1205, 1.37,
0.2489796, 1205, 1.534606,
0.4979592, 1205, 1.703955,
0.7469388, 1205, 1.876719,
0.9959184, 1205, 2.051601,
1.244898, 1205, 2.22736,
1.493878, 1205, 2.402837,
1.742857, 1205, 2.576962,
1.991837, 1205, 2.748774,
2.240816, 1205, 2.917426,
2.489796, 1205, 3.082181,
2.738775, 1205, 3.24242,
2.987755, 1205, 3.39763,
3.236735, 1205, 3.547404,
3.485714, 1205, 3.691429,
3.734694, 1205, 3.829483,
3.983674, 1205, 3.961423,
4.232653, 1205, 4.087174,
4.481633, 1205, 4.206727,
4.730612, 1205, 4.320121,
4.979592, 1205, 4.427444,
5.228571, 1205, 4.528821,
5.477551, 1205, 4.624406,
5.726531, 1205, 4.714378,
5.97551, 1205, 4.798935,
6.22449, 1205, 4.878289,
6.473469, 1205, 4.952663,
6.722449, 1205, 5.022283,
6.971428, 1205, 5.08738,
7.220408, 1205, 5.148185,
7.469388, 1205, 5.204926,
7.718368, 1205, 5.257828,
7.967347, 1205, 5.307111,
8.216327, 1205, 5.352987,
8.465306, 1205, 5.395664,
8.714286, 1205, 5.435337,
8.963265, 1205, 5.472197,
9.212245, 1205, 5.506425,
9.461225, 1205, 5.538192,
9.710204, 1205, 5.567663,
9.959184, 1205, 5.59499,
10.20816, 1205, 5.620321,
10.45714, 1205, 5.643792,
10.70612, 1205, 5.665532,
10.9551, 1205, 5.685664,
11.20408, 1205, 5.7043,
11.45306, 1205, 5.721547,
11.70204, 1205, 5.737505,
11.95102, 1205, 5.752267,
12.2, 1205, 5.76592
]);
var buf16 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf16);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc16 = gl.getUniformLocation(prog16,"mvMatrix");
var prMatLoc16 = gl.getUniformLocation(prog16,"prMatrix");
// ****** linestrip object 17 ******
var prog17  = gl.createProgram();
gl.attachShader(prog17, getShader( gl, "unnamed_chunk_3vshader17" ));
gl.attachShader(prog17, getShader( gl, "unnamed_chunk_3fshader17" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog17, 0, "aPos");
gl.bindAttribLocation(prog17, 1, "aCol");
gl.linkProgram(prog17);
var v=new Float32Array([
0, 1239, 1.37,
0.2489796, 1239, 1.566685,
0.4979592, 1239, 1.764751,
0.7469388, 1239, 1.961391,
0.9959184, 1239, 2.154168,
1.244898, 1239, 2.341052,
1.493878, 1239, 2.52043,
1.742857, 1239, 2.691091,
1.991837, 1239, 2.852191,
2.240816, 1239, 3.003212,
2.489796, 1239, 3.143914,
2.738775, 1239, 3.274287,
2.987755, 1239, 3.394501,
3.236735, 1239, 3.504873,
3.485714, 1239, 3.60582,
3.734694, 1239, 3.697834,
3.983674, 1239, 3.781454,
4.232653, 1239, 3.857241,
4.481633, 1239, 3.925767,
4.730612, 1239, 3.987597,
4.979592, 1239, 4.043281,
5.228571, 1239, 4.093346,
5.477551, 1239, 4.138294,
5.726531, 1239, 4.178594,
5.97551, 1239, 4.214686,
6.22449, 1239, 4.246975,
6.473469, 1239, 4.275836,
6.722449, 1239, 4.301612,
6.971428, 1239, 4.324617,
7.220408, 1239, 4.345134,
7.469388, 1239, 4.363423,
7.718368, 1239, 4.379717,
7.967347, 1239, 4.394228,
8.216327, 1239, 4.407145,
8.465306, 1239, 4.41864,
8.714286, 1239, 4.428865,
8.963265, 1239, 4.43796,
9.212245, 1239, 4.446046,
9.461225, 1239, 4.453234,
9.710204, 1239, 4.459622,
9.959184, 1239, 4.465299,
10.20816, 1239, 4.470343,
10.45714, 1239, 4.474823,
10.70612, 1239, 4.478804,
10.9551, 1239, 4.482338,
11.20408, 1239, 4.485478,
11.45306, 1239, 4.488266,
11.70204, 1239, 4.490741,
11.95102, 1239, 4.492939,
12.2, 1239, 4.49489
]);
var buf17 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf17);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc17 = gl.getUniformLocation(prog17,"mvMatrix");
var prMatLoc17 = gl.getUniformLocation(prog17,"prMatrix");
// ****** linestrip object 18 ******
var prog18  = gl.createProgram();
gl.attachShader(prog18, getShader( gl, "unnamed_chunk_3vshader18" ));
gl.attachShader(prog18, getShader( gl, "unnamed_chunk_3fshader18" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog18, 0, "aPos");
gl.bindAttribLocation(prog18, 1, "aCol");
gl.linkProgram(prog18);
var v=new Float32Array([
0, 1240, 1.37,
0.2489796, 1240, 1.525447,
0.4979592, 1240, 1.685542,
0.7469388, 1240, 1.849208,
0.9959184, 1240, 2.01538,
1.244898, 1240, 2.183024,
1.493878, 1240, 2.351155,
1.742857, 1240, 2.518849,
1.991837, 1240, 2.685256,
2.240816, 1240, 2.849604,
2.489796, 1240, 3.011205,
2.738775, 1240, 3.169458,
2.987755, 1240, 3.323843,
3.236735, 1240, 3.473926,
3.485714, 1240, 3.619349,
3.734694, 1240, 3.75983,
3.983674, 1240, 3.895153,
4.232653, 1240, 4.025166,
4.481633, 1240, 4.149775,
4.730612, 1240, 4.268934,
4.979592, 1240, 4.382642,
5.228571, 1240, 4.490938,
5.477551, 1240, 4.593893,
5.726531, 1240, 4.691605,
5.97551, 1240, 4.784197,
6.22449, 1240, 4.87181,
6.473469, 1240, 4.954601,
6.722449, 1240, 5.032737,
6.971428, 1240, 5.106395,
7.220408, 1240, 5.175755,
7.469388, 1240, 5.241004,
7.718368, 1240, 5.302329,
7.967347, 1240, 5.359914,
8.216327, 1240, 5.413947,
8.465306, 1240, 5.464606,
8.714286, 1240, 5.512072,
8.963265, 1240, 5.556516,
9.212245, 1240, 5.598105,
9.461225, 1240, 5.637003,
9.710204, 1240, 5.673364,
9.959184, 1240, 5.707337,
10.20816, 1240, 5.739066,
10.45714, 1240, 5.768686,
10.70612, 1240, 5.796327,
10.9551, 1240, 5.822113,
11.20408, 1240, 5.846159,
11.45306, 1240, 5.868575,
11.70204, 1240, 5.889468,
11.95102, 1240, 5.908935,
12.2, 1240, 5.927069
]);
var buf18 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf18);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc18 = gl.getUniformLocation(prog18,"mvMatrix");
var prMatLoc18 = gl.getUniformLocation(prog18,"prMatrix");
// ****** linestrip object 19 ******
var prog19  = gl.createProgram();
gl.attachShader(prog19, getShader( gl, "unnamed_chunk_3vshader19" ));
gl.attachShader(prog19, getShader( gl, "unnamed_chunk_3fshader19" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog19, 0, "aPos");
gl.bindAttribLocation(prog19, 1, "aCol");
gl.linkProgram(prog19);
var v=new Float32Array([
0, 1249, 1.37,
0.2489796, 1249, 1.563744,
0.4979592, 1249, 1.754537,
0.7469388, 1249, 1.939442,
0.9959184, 1249, 2.116163,
1.244898, 1249, 2.283027,
1.493878, 1249, 2.438929,
1.742857, 1249, 2.583258,
1.991837, 1249, 2.715807,
2.240816, 1249, 2.836693,
2.489796, 1249, 2.946277,
2.738775, 1249, 3.045093,
2.987755, 1249, 3.13379,
3.236735, 1249, 3.213086,
3.485714, 1249, 3.283733,
3.734694, 1249, 3.346483,
3.983674, 1249, 3.402072,
4.232653, 1249, 3.451205,
4.481633, 1249, 3.494544,
4.730612, 1249, 3.532706,
4.979592, 1249, 3.56626,
5.228571, 1249, 3.595723,
5.477551, 1249, 3.621563,
5.726531, 1249, 3.644204,
5.97551, 1249, 3.664025,
6.22449, 1249, 3.681364,
6.473469, 1249, 3.696521,
6.722449, 1249, 3.709764,
6.971428, 1249, 3.721328,
7.220408, 1249, 3.731422,
7.469388, 1249, 3.74023,
7.718368, 1249, 3.747913,
7.967347, 1249, 3.754612,
8.216327, 1249, 3.760453,
8.465306, 1249, 3.765543,
8.714286, 1249, 3.769979,
8.963265, 1249, 3.773844,
9.212245, 1249, 3.777212,
9.461225, 1249, 3.780145,
9.710204, 1249, 3.7827,
9.959184, 1249, 3.784925,
10.20816, 1249, 3.786862,
10.45714, 1249, 3.788549,
10.70612, 1249, 3.790018,
10.9551, 1249, 3.791297,
11.20408, 1249, 3.792411,
11.45306, 1249, 3.79338,
11.70204, 1249, 3.794224,
11.95102, 1249, 3.794958,
12.2, 1249, 3.795598
]);
var buf19 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf19);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc19 = gl.getUniformLocation(prog19,"mvMatrix");
var prMatLoc19 = gl.getUniformLocation(prog19,"prMatrix");
// ****** linestrip object 20 ******
var prog20  = gl.createProgram();
gl.attachShader(prog20, getShader( gl, "unnamed_chunk_3vshader20" ));
gl.attachShader(prog20, getShader( gl, "unnamed_chunk_3fshader20" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog20, 0, "aPos");
gl.bindAttribLocation(prog20, 1, "aCol");
gl.linkProgram(prog20);
var v=new Float32Array([
0, 1261, 1.37,
0.2489796, 1261, 1.525447,
0.4979592, 1261, 1.685542,
0.7469388, 1261, 1.849208,
0.9959184, 1261, 2.01538,
1.244898, 1261, 2.183024,
1.493878, 1261, 2.351155,
1.742857, 1261, 2.518849,
1.991837, 1261, 2.685256,
2.240816, 1261, 2.849604,
2.489796, 1261, 3.011205,
2.738775, 1261, 3.169458,
2.987755, 1261, 3.323843,
3.236735, 1261, 3.473926,
3.485714, 1261, 3.619349,
3.734694, 1261, 3.75983,
3.983674, 1261, 3.895153,
4.232653, 1261, 4.025166,
4.481633, 1261, 4.149775,
4.730612, 1261, 4.268934,
4.979592, 1261, 4.382642,
5.228571, 1261, 4.490938,
5.477551, 1261, 4.593893,
5.726531, 1261, 4.691605,
5.97551, 1261, 4.784197,
6.22449, 1261, 4.87181,
6.473469, 1261, 4.954601,
6.722449, 1261, 5.032737,
6.971428, 1261, 5.106395,
7.220408, 1261, 5.175755,
7.469388, 1261, 5.241004,
7.718368, 1261, 5.302329,
7.967347, 1261, 5.359914,
8.216327, 1261, 5.413947,
8.465306, 1261, 5.464606,
8.714286, 1261, 5.512072,
8.963265, 1261, 5.556516,
9.212245, 1261, 5.598105,
9.461225, 1261, 5.637003,
9.710204, 1261, 5.673364,
9.959184, 1261, 5.707337,
10.20816, 1261, 5.739066,
10.45714, 1261, 5.768686,
10.70612, 1261, 5.796327,
10.9551, 1261, 5.822113,
11.20408, 1261, 5.846159,
11.45306, 1261, 5.868575,
11.70204, 1261, 5.889468,
11.95102, 1261, 5.908935,
12.2, 1261, 5.927069
]);
var buf20 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf20);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc20 = gl.getUniformLocation(prog20,"mvMatrix");
var prMatLoc20 = gl.getUniformLocation(prog20,"prMatrix");
// ****** linestrip object 21 ******
var prog21  = gl.createProgram();
gl.attachShader(prog21, getShader( gl, "unnamed_chunk_3vshader21" ));
gl.attachShader(prog21, getShader( gl, "unnamed_chunk_3fshader21" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog21, 0, "aPos");
gl.bindAttribLocation(prog21, 1, "aCol");
gl.linkProgram(prog21);
var v=new Float32Array([
0, 1269, 1.37,
0.2489796, 1269, 1.566685,
0.4979592, 1269, 1.764751,
0.7469388, 1269, 1.961391,
0.9959184, 1269, 2.154168,
1.244898, 1269, 2.341052,
1.493878, 1269, 2.52043,
1.742857, 1269, 2.691091,
1.991837, 1269, 2.852191,
2.240816, 1269, 3.003212,
2.489796, 1269, 3.143914,
2.738775, 1269, 3.274287,
2.987755, 1269, 3.394501,
3.236735, 1269, 3.504873,
3.485714, 1269, 3.60582,
3.734694, 1269, 3.697834,
3.983674, 1269, 3.781454,
4.232653, 1269, 3.857241,
4.481633, 1269, 3.925767,
4.730612, 1269, 3.987597,
4.979592, 1269, 4.043281,
5.228571, 1269, 4.093346,
5.477551, 1269, 4.138294,
5.726531, 1269, 4.178594,
5.97551, 1269, 4.214686,
6.22449, 1269, 4.246975,
6.473469, 1269, 4.275836,
6.722449, 1269, 4.301612,
6.971428, 1269, 4.324617,
7.220408, 1269, 4.345134,
7.469388, 1269, 4.363423,
7.718368, 1269, 4.379717,
7.967347, 1269, 4.394228,
8.216327, 1269, 4.407145,
8.465306, 1269, 4.41864,
8.714286, 1269, 4.428865,
8.963265, 1269, 4.43796,
9.212245, 1269, 4.446046,
9.461225, 1269, 4.453234,
9.710204, 1269, 4.459622,
9.959184, 1269, 4.465299,
10.20816, 1269, 4.470343,
10.45714, 1269, 4.474823,
10.70612, 1269, 4.478804,
10.9551, 1269, 4.482338,
11.20408, 1269, 4.485478,
11.45306, 1269, 4.488266,
11.70204, 1269, 4.490741,
11.95102, 1269, 4.492939,
12.2, 1269, 4.49489
]);
var buf21 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf21);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc21 = gl.getUniformLocation(prog21,"mvMatrix");
var prMatLoc21 = gl.getUniformLocation(prog21,"prMatrix");
// ****** linestrip object 22 ******
var prog22  = gl.createProgram();
gl.attachShader(prog22, getShader( gl, "unnamed_chunk_3vshader22" ));
gl.attachShader(prog22, getShader( gl, "unnamed_chunk_3fshader22" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog22, 0, "aPos");
gl.bindAttribLocation(prog22, 1, "aCol");
gl.linkProgram(prog22);
var v=new Float32Array([
0, 1271, 1.37,
0.2489796, 1271, 1.515394,
0.4979592, 1271, 1.665198,
0.7469388, 1271, 1.818563,
0.9959184, 1271, 1.974642,
1.244898, 1271, 2.132602,
1.493878, 1271, 2.291634,
1.742857, 1271, 2.450969,
1.991837, 1271, 2.609884,
2.240816, 1271, 2.767707,
2.489796, 1271, 2.923825,
2.738775, 1271, 3.077684,
2.987755, 1271, 3.228791,
3.236735, 1271, 3.376716,
3.485714, 1271, 3.521087,
3.734694, 1271, 3.66159,
3.983674, 1271, 3.797969,
4.232653, 1271, 3.930016,
4.481633, 1271, 4.057574,
4.730612, 1271, 4.180531,
4.979592, 1271, 4.298811,
5.228571, 1271, 4.41238,
5.477551, 1271, 4.521231,
5.726531, 1271, 4.62539,
5.97551, 1271, 4.724905,
6.22449, 1271, 4.819846,
6.473469, 1271, 4.910301,
6.722449, 1271, 4.996375,
6.971428, 1271, 5.078183,
7.220408, 1271, 5.15585,
7.469388, 1271, 5.229512,
7.718368, 1271, 5.299307,
7.967347, 1271, 5.365379,
8.216327, 1271, 5.427875,
8.465306, 1271, 5.486941,
8.714286, 1271, 5.542725,
8.963265, 1271, 5.595373,
9.212245, 1271, 5.64503,
9.461225, 1271, 5.691837,
9.710204, 1271, 5.735934,
9.959184, 1271, 5.777456,
10.20816, 1271, 5.816534,
10.45714, 1271, 5.853295,
10.70612, 1271, 5.887861,
10.9551, 1271, 5.920352,
11.20408, 1271, 5.95088,
11.45306, 1271, 5.979553,
11.70204, 1271, 6.006475,
11.95102, 1271, 6.031747,
12.2, 1271, 6.055462
]);
var buf22 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf22);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc22 = gl.getUniformLocation(prog22,"mvMatrix");
var prMatLoc22 = gl.getUniformLocation(prog22,"prMatrix");
// ****** linestrip object 23 ******
var prog23  = gl.createProgram();
gl.attachShader(prog23, getShader( gl, "unnamed_chunk_3vshader23" ));
gl.attachShader(prog23, getShader( gl, "unnamed_chunk_3fshader23" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog23, 0, "aPos");
gl.bindAttribLocation(prog23, 1, "aCol");
gl.linkProgram(prog23);
var v=new Float32Array([
0, 1299, 1.37,
0.2489796, 1299, 1.566685,
0.4979592, 1299, 1.764751,
0.7469388, 1299, 1.961391,
0.9959184, 1299, 2.154168,
1.244898, 1299, 2.341052,
1.493878, 1299, 2.52043,
1.742857, 1299, 2.691091,
1.991837, 1299, 2.852191,
2.240816, 1299, 3.003212,
2.489796, 1299, 3.143914,
2.738775, 1299, 3.274287,
2.987755, 1299, 3.394501,
3.236735, 1299, 3.504873,
3.485714, 1299, 3.60582,
3.734694, 1299, 3.697834,
3.983674, 1299, 3.781454,
4.232653, 1299, 3.857241,
4.481633, 1299, 3.925767,
4.730612, 1299, 3.987597,
4.979592, 1299, 4.043281,
5.228571, 1299, 4.093346,
5.477551, 1299, 4.138294,
5.726531, 1299, 4.178594,
5.97551, 1299, 4.214686,
6.22449, 1299, 4.246975,
6.473469, 1299, 4.275836,
6.722449, 1299, 4.301612,
6.971428, 1299, 4.324617,
7.220408, 1299, 4.345134,
7.469388, 1299, 4.363423,
7.718368, 1299, 4.379717,
7.967347, 1299, 4.394228,
8.216327, 1299, 4.407145,
8.465306, 1299, 4.41864,
8.714286, 1299, 4.428865,
8.963265, 1299, 4.43796,
9.212245, 1299, 4.446046,
9.461225, 1299, 4.453234,
9.710204, 1299, 4.459622,
9.959184, 1299, 4.465299,
10.20816, 1299, 4.470343,
10.45714, 1299, 4.474823,
10.70612, 1299, 4.478804,
10.9551, 1299, 4.482338,
11.20408, 1299, 4.485478,
11.45306, 1299, 4.488266,
11.70204, 1299, 4.490741,
11.95102, 1299, 4.492939,
12.2, 1299, 4.49489
]);
var buf23 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf23);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc23 = gl.getUniformLocation(prog23,"mvMatrix");
var prMatLoc23 = gl.getUniformLocation(prog23,"prMatrix");
// ****** linestrip object 24 ******
var prog24  = gl.createProgram();
gl.attachShader(prog24, getShader( gl, "unnamed_chunk_3vshader24" ));
gl.attachShader(prog24, getShader( gl, "unnamed_chunk_3fshader24" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog24, 0, "aPos");
gl.bindAttribLocation(prog24, 1, "aCol");
gl.linkProgram(prog24);
var v=new Float32Array([
0, 1302, 1.37,
0.2489796, 1302, 1.563744,
0.4979592, 1302, 1.754537,
0.7469388, 1302, 1.939442,
0.9959184, 1302, 2.116163,
1.244898, 1302, 2.283027,
1.493878, 1302, 2.438929,
1.742857, 1302, 2.583258,
1.991837, 1302, 2.715807,
2.240816, 1302, 2.836693,
2.489796, 1302, 2.946277,
2.738775, 1302, 3.045093,
2.987755, 1302, 3.13379,
3.236735, 1302, 3.213086,
3.485714, 1302, 3.283733,
3.734694, 1302, 3.346483,
3.983674, 1302, 3.402072,
4.232653, 1302, 3.451205,
4.481633, 1302, 3.494544,
4.730612, 1302, 3.532706,
4.979592, 1302, 3.56626,
5.228571, 1302, 3.595723,
5.477551, 1302, 3.621563,
5.726531, 1302, 3.644204,
5.97551, 1302, 3.664025,
6.22449, 1302, 3.681364,
6.473469, 1302, 3.696521,
6.722449, 1302, 3.709764,
6.971428, 1302, 3.721328,
7.220408, 1302, 3.731422,
7.469388, 1302, 3.74023,
7.718368, 1302, 3.747913,
7.967347, 1302, 3.754612,
8.216327, 1302, 3.760453,
8.465306, 1302, 3.765543,
8.714286, 1302, 3.769979,
8.963265, 1302, 3.773844,
9.212245, 1302, 3.777212,
9.461225, 1302, 3.780145,
9.710204, 1302, 3.7827,
9.959184, 1302, 3.784925,
10.20816, 1302, 3.786862,
10.45714, 1302, 3.788549,
10.70612, 1302, 3.790018,
10.9551, 1302, 3.791297,
11.20408, 1302, 3.792411,
11.45306, 1302, 3.79338,
11.70204, 1302, 3.794224,
11.95102, 1302, 3.794958,
12.2, 1302, 3.795598
]);
var buf24 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf24);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc24 = gl.getUniformLocation(prog24,"mvMatrix");
var prMatLoc24 = gl.getUniformLocation(prog24,"prMatrix");
// ****** linestrip object 25 ******
var prog25  = gl.createProgram();
gl.attachShader(prog25, getShader( gl, "unnamed_chunk_3vshader25" ));
gl.attachShader(prog25, getShader( gl, "unnamed_chunk_3fshader25" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog25, 0, "aPos");
gl.bindAttribLocation(prog25, 1, "aCol");
gl.linkProgram(prog25);
var v=new Float32Array([
0, 1305, 1.37,
0.2489796, 1305, 1.567381,
0.4979592, 1305, 1.76487,
0.7469388, 1305, 1.959536,
0.9959184, 1305, 2.148906,
1.244898, 1305, 2.330997,
1.493878, 1305, 2.504301,
1.742857, 1305, 2.667759,
1.991837, 1305, 2.820706,
2.240816, 1305, 2.962815,
2.489796, 1305, 3.094038,
2.738775, 1305, 3.214548,
2.987755, 1305, 3.324688,
3.236735, 1305, 3.424923,
3.485714, 1305, 3.515803,
3.734694, 1305, 3.597929,
3.983674, 1305, 3.671929,
4.232653, 1305, 3.738435,
4.481633, 1305, 3.79807,
4.730612, 1305, 3.851439,
4.979592, 1305, 3.899115,
5.228571, 1305, 3.94164,
5.477551, 1305, 3.979519,
5.726531, 1305, 4.013217,
5.97551, 1305, 4.043165,
6.22449, 1305, 4.069756,
6.473469, 1305, 4.093345,
6.722449, 1305, 4.114257,
6.971428, 1305, 4.132783,
7.220408, 1305, 4.149187,
7.469388, 1305, 4.163703,
7.718368, 1305, 4.176545,
7.967347, 1305, 4.1879,
8.216327, 1305, 4.197937,
8.465306, 1305, 4.206807,
8.714286, 1305, 4.214643,
8.963265, 1305, 4.221563,
9.212245, 1305, 4.227674,
9.461225, 1305, 4.23307,
9.710204, 1305, 4.237833,
9.959184, 1305, 4.242037,
10.20816, 1305, 4.245747,
10.45714, 1305, 4.249021,
10.70612, 1305, 4.25191,
10.9551, 1305, 4.254458,
11.20408, 1305, 4.256706,
11.45306, 1305, 4.258689,
11.70204, 1305, 4.260438,
11.95102, 1305, 4.261981,
12.2, 1305, 4.263342
]);
var buf25 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf25);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc25 = gl.getUniformLocation(prog25,"mvMatrix");
var prMatLoc25 = gl.getUniformLocation(prog25,"prMatrix");
// ****** linestrip object 26 ******
var prog26  = gl.createProgram();
gl.attachShader(prog26, getShader( gl, "unnamed_chunk_3vshader26" ));
gl.attachShader(prog26, getShader( gl, "unnamed_chunk_3fshader26" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog26, 0, "aPos");
gl.bindAttribLocation(prog26, 1, "aCol");
gl.linkProgram(prog26);
var v=new Float32Array([
0, 1321, 1.37,
0.2489796, 1321, 1.560904,
0.4979592, 1321, 1.755127,
0.7469388, 1321, 1.950275,
0.9959184, 1321, 2.144163,
1.244898, 1321, 2.334864,
1.493878, 1321, 2.520737,
1.742857, 1321, 2.70043,
1.991837, 1321, 2.87288,
2.240816, 1321, 3.037289,
2.489796, 1321, 3.193105,
2.738775, 1321, 3.339994,
2.987755, 1321, 3.477802,
3.236735, 1321, 3.606537,
3.485714, 1321, 3.726329,
3.734694, 1321, 3.837413,
3.983674, 1321, 3.940099,
4.232653, 1321, 4.034756,
4.481633, 1321, 4.12179,
4.730612, 1321, 4.201633,
4.979592, 1321, 4.274731,
5.228571, 1321, 4.341528,
5.477551, 1321, 4.402469,
5.726531, 1321, 4.457983,
5.97551, 1321, 4.508487,
6.22449, 1321, 4.554378,
6.473469, 1321, 4.596031,
6.722449, 1321, 4.633801,
6.971428, 1321, 4.668021,
7.220408, 1321, 4.698999,
7.469388, 1321, 4.727024,
7.718368, 1321, 4.75236,
7.967347, 1321, 4.775253,
8.216327, 1321, 4.795928,
8.465306, 1321, 4.81459,
8.714286, 1321, 4.831429,
8.963265, 1321, 4.846617,
9.212245, 1321, 4.860312,
9.461225, 1321, 4.872656,
9.710204, 1321, 4.88378,
9.959184, 1321, 4.893803,
10.20816, 1321, 4.90283,
10.45714, 1321, 4.91096,
10.70612, 1321, 4.918279,
10.9551, 1321, 4.924869,
11.20408, 1321, 4.9308,
11.45306, 1321, 4.936139,
11.70204, 1321, 4.940943,
11.95102, 1321, 4.945266,
12.2, 1321, 4.949155
]);
var buf26 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf26);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc26 = gl.getUniformLocation(prog26,"mvMatrix");
var prMatLoc26 = gl.getUniformLocation(prog26,"prMatrix");
// ****** linestrip object 27 ******
var prog27  = gl.createProgram();
gl.attachShader(prog27, getShader( gl, "unnamed_chunk_3vshader27" ));
gl.attachShader(prog27, getShader( gl, "unnamed_chunk_3fshader27" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog27, 0, "aPos");
gl.bindAttribLocation(prog27, 1, "aCol");
gl.linkProgram(prog27);
var v=new Float32Array([
0, 1329, 1.37,
0.2489796, 1329, 1.566685,
0.4979592, 1329, 1.764751,
0.7469388, 1329, 1.961391,
0.9959184, 1329, 2.154168,
1.244898, 1329, 2.341052,
1.493878, 1329, 2.52043,
1.742857, 1329, 2.691091,
1.991837, 1329, 2.852191,
2.240816, 1329, 3.003212,
2.489796, 1329, 3.143914,
2.738775, 1329, 3.274287,
2.987755, 1329, 3.394501,
3.236735, 1329, 3.504873,
3.485714, 1329, 3.60582,
3.734694, 1329, 3.697834,
3.983674, 1329, 3.781454,
4.232653, 1329, 3.857241,
4.481633, 1329, 3.925767,
4.730612, 1329, 3.987597,
4.979592, 1329, 4.043281,
5.228571, 1329, 4.093346,
5.477551, 1329, 4.138294,
5.726531, 1329, 4.178594,
5.97551, 1329, 4.214686,
6.22449, 1329, 4.246975,
6.473469, 1329, 4.275836,
6.722449, 1329, 4.301612,
6.971428, 1329, 4.324617,
7.220408, 1329, 4.345134,
7.469388, 1329, 4.363423,
7.718368, 1329, 4.379717,
7.967347, 1329, 4.394228,
8.216327, 1329, 4.407145,
8.465306, 1329, 4.41864,
8.714286, 1329, 4.428865,
8.963265, 1329, 4.43796,
9.212245, 1329, 4.446046,
9.461225, 1329, 4.453234,
9.710204, 1329, 4.459622,
9.959184, 1329, 4.465299,
10.20816, 1329, 4.470343,
10.45714, 1329, 4.474823,
10.70612, 1329, 4.478804,
10.9551, 1329, 4.482338,
11.20408, 1329, 4.485478,
11.45306, 1329, 4.488266,
11.70204, 1329, 4.490741,
11.95102, 1329, 4.492939,
12.2, 1329, 4.49489
]);
var buf27 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf27);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc27 = gl.getUniformLocation(prog27,"mvMatrix");
var prMatLoc27 = gl.getUniformLocation(prog27,"prMatrix");
// ****** linestrip object 28 ******
var prog28  = gl.createProgram();
gl.attachShader(prog28, getShader( gl, "unnamed_chunk_3vshader28" ));
gl.attachShader(prog28, getShader( gl, "unnamed_chunk_3fshader28" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog28, 0, "aPos");
gl.bindAttribLocation(prog28, 1, "aCol");
gl.linkProgram(prog28);
var v=new Float32Array([
0, 1335, 1.37,
0.2489796, 1335, 1.556035,
0.4979592, 1335, 1.746043,
0.7469388, 1335, 1.937887,
0.9959184, 1335, 2.129574,
1.244898, 1335, 2.319307,
1.493878, 1335, 2.505509,
1.742857, 1335, 2.686839,
1.991837, 1335, 2.862195,
2.240816, 1335, 3.030702,
2.489796, 1335, 3.191705,
2.738775, 1335, 3.344743,
2.987755, 1335, 3.48953,
3.236735, 1335, 3.625929,
3.485714, 1335, 3.753936,
3.734694, 1335, 3.873649,
3.983674, 1335, 3.985255,
4.232653, 1335, 4.089006,
4.481633, 1335, 4.185209,
4.730612, 1335, 4.274205,
4.979592, 1335, 4.35636,
5.228571, 1335, 4.432055,
5.477551, 1335, 4.50168,
5.726531, 1335, 4.565619,
5.97551, 1335, 4.624255,
6.22449, 1335, 4.677959,
6.473469, 1335, 4.727089,
6.722449, 1335, 4.771987,
6.971428, 1335, 4.81298,
7.220408, 1335, 4.850374,
7.469388, 1335, 4.88446,
7.718368, 1335, 4.915507,
7.967347, 1335, 4.94377,
8.216327, 1335, 4.969483,
8.465306, 1335, 4.992864,
8.714286, 1335, 5.014114,
8.963265, 1335, 5.033419,
9.212245, 1335, 5.050951,
9.461225, 1335, 5.066868,
9.710204, 1335, 5.081312,
9.959184, 1335, 5.094417,
10.20816, 1335, 5.106304,
10.45714, 1335, 5.117084,
10.70612, 1335, 5.126857,
10.9551, 1335, 5.135716,
11.20408, 1335, 5.143745,
11.45306, 1335, 5.151021,
11.70204, 1335, 5.157613,
11.95102, 1335, 5.163585,
12.2, 1335, 5.168994
]);
var buf28 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf28);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc28 = gl.getUniformLocation(prog28,"mvMatrix");
var prMatLoc28 = gl.getUniformLocation(prog28,"prMatrix");
// ****** linestrip object 29 ******
var prog29  = gl.createProgram();
gl.attachShader(prog29, getShader( gl, "unnamed_chunk_3vshader29" ));
gl.attachShader(prog29, getShader( gl, "unnamed_chunk_3fshader29" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog29, 0, "aPos");
gl.bindAttribLocation(prog29, 1, "aCol");
gl.linkProgram(prog29);
var v=new Float32Array([
0, 1400, 1.37,
0.2489796, 1400, 1.567381,
0.4979592, 1400, 1.76487,
0.7469388, 1400, 1.959536,
0.9959184, 1400, 2.148906,
1.244898, 1400, 2.330997,
1.493878, 1400, 2.504301,
1.742857, 1400, 2.667759,
1.991837, 1400, 2.820706,
2.240816, 1400, 2.962815,
2.489796, 1400, 3.094038,
2.738775, 1400, 3.214548,
2.987755, 1400, 3.324688,
3.236735, 1400, 3.424923,
3.485714, 1400, 3.515803,
3.734694, 1400, 3.597929,
3.983674, 1400, 3.671929,
4.232653, 1400, 3.738435,
4.481633, 1400, 3.79807,
4.730612, 1400, 3.851439,
4.979592, 1400, 3.899115,
5.228571, 1400, 3.94164,
5.477551, 1400, 3.979519,
5.726531, 1400, 4.013217,
5.97551, 1400, 4.043165,
6.22449, 1400, 4.069756,
6.473469, 1400, 4.093345,
6.722449, 1400, 4.114257,
6.971428, 1400, 4.132783,
7.220408, 1400, 4.149187,
7.469388, 1400, 4.163703,
7.718368, 1400, 4.176545,
7.967347, 1400, 4.1879,
8.216327, 1400, 4.197937,
8.465306, 1400, 4.206807,
8.714286, 1400, 4.214643,
8.963265, 1400, 4.221563,
9.212245, 1400, 4.227674,
9.461225, 1400, 4.23307,
9.710204, 1400, 4.237833,
9.959184, 1400, 4.242037,
10.20816, 1400, 4.245747,
10.45714, 1400, 4.249021,
10.70612, 1400, 4.25191,
10.9551, 1400, 4.254458,
11.20408, 1400, 4.256706,
11.45306, 1400, 4.258689,
11.70204, 1400, 4.260438,
11.95102, 1400, 4.261981,
12.2, 1400, 4.263342
]);
var buf29 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf29);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc29 = gl.getUniformLocation(prog29,"mvMatrix");
var prMatLoc29 = gl.getUniformLocation(prog29,"prMatrix");
// ****** linestrip object 30 ******
var prog30  = gl.createProgram();
gl.attachShader(prog30, getShader( gl, "unnamed_chunk_3vshader30" ));
gl.attachShader(prog30, getShader( gl, "unnamed_chunk_3fshader30" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog30, 0, "aPos");
gl.bindAttribLocation(prog30, 1, "aCol");
gl.linkProgram(prog30);
var v=new Float32Array([
0, 1205, 1.37,
0.2857143, 1205, 1.528532,
0.5714286, 1205, 1.695774,
0.8571429, 1205, 1.871234,
1.142857, 1205, 2.054356,
1.428571, 1205, 2.244529,
1.714286, 1205, 2.441098,
2, 1205, 2.643375,
2.285714, 1205, 2.850647,
2.571429, 1205, 3.062186,
2.857143, 1205, 3.277262,
3.142857, 1205, 3.495147,
3.428571, 1205, 3.715124,
3.714286, 1205, 3.936494,
4, 1205, 4.158581,
4.285714, 1205, 4.38074,
4.571429, 1205, 4.602357,
4.857143, 1205, 4.822854,
5.142857, 1205, 5.041692,
5.428571, 1205, 5.258371,
5.714286, 1205, 5.472435,
6, 1205, 5.683467,
6.285714, 1205, 5.891092,
6.571429, 1205, 6.094976,
6.857143, 1205, 6.294824,
7.142857, 1205, 6.490381,
7.428571, 1205, 6.681428,
7.714286, 1205, 6.867782,
8, 1205, 7.049293,
8.285714, 1205, 7.22584,
8.571428, 1205, 7.397336,
8.857142, 1205, 7.563715,
9.142858, 1205, 7.724942,
9.428572, 1205, 7.880999,
9.714286, 1205, 8.031893,
10, 1205, 8.177647,
10.28571, 1205, 8.318301,
10.57143, 1205, 8.453912,
10.85714, 1205, 8.584547,
11.14286, 1205, 8.710287,
11.42857, 1205, 8.831223,
11.71429, 1205, 8.947451,
12, 1205, 9.059077,
12.28571, 1205, 9.166214,
12.57143, 1205, 9.268977,
12.85714, 1205, 9.367488,
13.14286, 1205, 9.461868,
13.42857, 1205, 9.552242,
13.71429, 1205, 9.638739,
14, 1205, 9.721482
]);
var buf30 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf30);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc30 = gl.getUniformLocation(prog30,"mvMatrix");
var prMatLoc30 = gl.getUniformLocation(prog30,"prMatrix");
// ****** linestrip object 31 ******
var prog31  = gl.createProgram();
gl.attachShader(prog31, getShader( gl, "unnamed_chunk_3vshader31" ));
gl.attachShader(prog31, getShader( gl, "unnamed_chunk_3fshader31" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog31, 0, "aPos");
gl.bindAttribLocation(prog31, 1, "aCol");
gl.linkProgram(prog31);
var v=new Float32Array([
0, 1231, 1.37,
0.2857143, 1231, 1.529543,
0.5714286, 1231, 1.695386,
0.8571429, 1231, 1.866578,
1.142857, 1231, 2.042146,
1.428571, 1231, 2.221108,
1.714286, 1231, 2.402494,
2, 1231, 2.585361,
2.285714, 1231, 2.768809,
2.571429, 1231, 2.951985,
2.857143, 1231, 3.134097,
3.142857, 1231, 3.31442,
3.428571, 1231, 3.492295,
3.714286, 1231, 3.667135,
4, 1231, 3.838423,
4.285714, 1231, 4.005713,
4.571429, 1231, 4.168627,
4.857143, 1231, 4.32685,
5.142857, 1231, 4.480132,
5.428571, 1231, 4.628275,
5.714286, 1231, 4.771137,
6, 1231, 4.908622,
6.285714, 1231, 5.040679,
6.571429, 1231, 5.167293,
6.857143, 1231, 5.288485,
7.142857, 1231, 5.404304,
7.428571, 1231, 5.514827,
7.714286, 1231, 5.620151,
8, 1231, 5.720392,
8.285714, 1231, 5.815681,
8.571428, 1231, 5.906161,
8.857142, 1231, 5.991986,
9.142858, 1231, 6.073314,
9.428572, 1231, 6.150311,
9.714286, 1231, 6.223146,
10, 1231, 6.291988,
10.28571, 1231, 6.357008,
10.57143, 1231, 6.418376,
10.85714, 1231, 6.476258,
11.14286, 1231, 6.53082,
11.42857, 1231, 6.582223,
11.71429, 1231, 6.630623,
12, 1231, 6.676174,
12.28571, 1231, 6.719024,
12.57143, 1231, 6.759315,
12.85714, 1231, 6.797184,
13.14286, 1231, 6.832764,
13.42857, 1231, 6.866181,
13.71429, 1231, 6.897557,
14, 1231, 6.927006
]);
var buf31 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf31);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc31 = gl.getUniformLocation(prog31,"mvMatrix");
var prMatLoc31 = gl.getUniformLocation(prog31,"prMatrix");
// ****** linestrip object 32 ******
var prog32  = gl.createProgram();
gl.attachShader(prog32, getShader( gl, "unnamed_chunk_3vshader32" ));
gl.attachShader(prog32, getShader( gl, "unnamed_chunk_3fshader32" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog32, 0, "aPos");
gl.bindAttribLocation(prog32, 1, "aCol");
gl.linkProgram(prog32);
var v=new Float32Array([
0, 1239, 1.37,
0.2857143, 1239, 1.529543,
0.5714286, 1239, 1.695386,
0.8571429, 1239, 1.866578,
1.142857, 1239, 2.042146,
1.428571, 1239, 2.221108,
1.714286, 1239, 2.402494,
2, 1239, 2.585361,
2.285714, 1239, 2.768809,
2.571429, 1239, 2.951985,
2.857143, 1239, 3.134097,
3.142857, 1239, 3.31442,
3.428571, 1239, 3.492295,
3.714286, 1239, 3.667135,
4, 1239, 3.838423,
4.285714, 1239, 4.005713,
4.571429, 1239, 4.168627,
4.857143, 1239, 4.32685,
5.142857, 1239, 4.480132,
5.428571, 1239, 4.628275,
5.714286, 1239, 4.771137,
6, 1239, 4.908622,
6.285714, 1239, 5.040679,
6.571429, 1239, 5.167293,
6.857143, 1239, 5.288485,
7.142857, 1239, 5.404304,
7.428571, 1239, 5.514827,
7.714286, 1239, 5.620151,
8, 1239, 5.720392,
8.285714, 1239, 5.815681,
8.571428, 1239, 5.906161,
8.857142, 1239, 5.991986,
9.142858, 1239, 6.073314,
9.428572, 1239, 6.150311,
9.714286, 1239, 6.223146,
10, 1239, 6.291988,
10.28571, 1239, 6.357008,
10.57143, 1239, 6.418376,
10.85714, 1239, 6.476258,
11.14286, 1239, 6.53082,
11.42857, 1239, 6.582223,
11.71429, 1239, 6.630623,
12, 1239, 6.676174,
12.28571, 1239, 6.719024,
12.57143, 1239, 6.759315,
12.85714, 1239, 6.797184,
13.14286, 1239, 6.832764,
13.42857, 1239, 6.866181,
13.71429, 1239, 6.897557,
14, 1239, 6.927006
]);
var buf32 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf32);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc32 = gl.getUniformLocation(prog32,"mvMatrix");
var prMatLoc32 = gl.getUniformLocation(prog32,"prMatrix");
// ****** linestrip object 33 ******
var prog33  = gl.createProgram();
gl.attachShader(prog33, getShader( gl, "unnamed_chunk_3vshader33" ));
gl.attachShader(prog33, getShader( gl, "unnamed_chunk_3fshader33" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog33, 0, "aPos");
gl.bindAttribLocation(prog33, 1, "aCol");
gl.linkProgram(prog33);
var v=new Float32Array([
0, 1240, 1.37,
0.2857143, 1240, 1.533392,
0.5714286, 1240, 1.705075,
0.8571429, 1240, 1.88433,
1.142857, 1240, 2.070375,
1.428571, 1240, 2.262383,
1.714286, 1240, 2.459495,
2, 1240, 2.660839,
2.285714, 1240, 2.865541,
2.571429, 1240, 3.072735,
2.857143, 1240, 3.281577,
3.142857, 1240, 3.491254,
3.428571, 1240, 3.700991,
3.714286, 1240, 3.910057,
4, 1240, 4.117769,
4.285714, 1240, 4.323498,
4.571429, 1240, 4.52667,
4.857143, 1240, 4.726766,
5.142857, 1240, 4.923322,
5.428571, 1240, 5.115932,
5.714286, 1240, 5.30424,
6, 1240, 5.487947,
6.285714, 1240, 5.666798,
6.571429, 1240, 5.84059,
6.857143, 1240, 6.009159,
7.142857, 1240, 6.172384,
7.428571, 1240, 6.330182,
7.714286, 1240, 6.482502,
8, 1240, 6.629326,
8.285714, 1240, 6.770663,
8.571428, 1240, 6.906546,
8.857142, 1240, 7.037029,
9.142858, 1240, 7.162187,
9.428572, 1240, 7.282112,
9.714286, 1240, 7.396906,
10, 1240, 7.506689,
10.28571, 1240, 7.611584,
10.57143, 1240, 7.711728,
10.85714, 1240, 7.807259,
11.14286, 1240, 7.898324,
11.42857, 1240, 7.985072,
11.71429, 1240, 8.067652,
12, 1240, 8.146216,
12.28571, 1240, 8.220918,
12.57143, 1240, 8.291906,
12.85714, 1240, 8.359333,
13.14286, 1240, 8.423344,
13.42857, 1240, 8.484086,
13.71429, 1240, 8.5417,
14, 1240, 8.596327
]);
var buf33 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf33);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc33 = gl.getUniformLocation(prog33,"mvMatrix");
var prMatLoc33 = gl.getUniformLocation(prog33,"prMatrix");
// ****** linestrip object 34 ******
var prog34  = gl.createProgram();
gl.attachShader(prog34, getShader( gl, "unnamed_chunk_3vshader34" ));
gl.attachShader(prog34, getShader( gl, "unnamed_chunk_3fshader34" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog34, 0, "aPos");
gl.bindAttribLocation(prog34, 1, "aCol");
gl.linkProgram(prog34);
var v=new Float32Array([
0, 1261, 1.37,
0.2857143, 1261, 1.533142,
0.5714286, 1261, 1.703877,
0.8571429, 1261, 1.881366,
1.142857, 1261, 2.064717,
1.428571, 1261, 2.253011,
1.714286, 1261, 2.445312,
2, 1261, 2.640687,
2.285714, 1261, 2.838219,
2.571429, 1261, 3.037019,
2.857143, 1261, 3.236237,
3.142857, 1261, 3.43507,
3.428571, 1261, 3.632769,
3.714286, 1261, 3.828644,
4, 1261, 4.022064,
4.285714, 1261, 4.212465,
4.571429, 1261, 4.399343,
4.857143, 1261, 4.582258,
5.142857, 1261, 4.760833,
5.428571, 1261, 4.934747,
5.714286, 1261, 5.103736,
6, 1261, 5.26759,
6.285714, 1261, 5.426145,
6.571429, 1261, 5.579284,
6.857143, 1261, 5.726931,
7.142857, 1261, 5.869047,
7.428571, 1261, 6.005627,
7.714286, 1261, 6.136693,
8, 1261, 6.262298,
8.285714, 1261, 6.382512,
8.571428, 1261, 6.497429,
8.857142, 1261, 6.607158,
9.142858, 1261, 6.711822,
9.428572, 1261, 6.811554,
9.714286, 1261, 6.906498,
10, 1261, 6.996805,
10.28571, 1261, 7.08263,
10.57143, 1261, 7.164132,
10.85714, 1261, 7.241473,
11.14286, 1261, 7.314816,
11.42857, 1261, 7.384322,
11.71429, 1261, 7.450152,
12, 1261, 7.512467,
12.28571, 1261, 7.571422,
12.57143, 1261, 7.627171,
12.85714, 1261, 7.679863,
13.14286, 1261, 7.729645,
13.42857, 1261, 7.776658,
13.71429, 1261, 7.821038,
14, 1261, 7.862919
]);
var buf34 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf34);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc34 = gl.getUniformLocation(prog34,"mvMatrix");
var prMatLoc34 = gl.getUniformLocation(prog34,"prMatrix");
// ****** linestrip object 35 ******
var prog35  = gl.createProgram();
gl.attachShader(prog35, getShader( gl, "unnamed_chunk_3vshader35" ));
gl.attachShader(prog35, getShader( gl, "unnamed_chunk_3fshader35" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog35, 0, "aPos");
gl.bindAttribLocation(prog35, 1, "aCol");
gl.linkProgram(prog35);
var v=new Float32Array([
0, 1269, 1.37,
0.2857143, 1269, 1.526687,
0.5714286, 1269, 1.688955,
0.8571429, 1269, 1.855826,
1.142857, 1269, 2.026308,
1.428571, 1269, 2.199419,
1.714286, 1269, 2.374199,
2, 1269, 2.549728,
2.285714, 1269, 2.725136,
2.571429, 1269, 2.899613,
2.857143, 1269, 3.072417,
3.142857, 1269, 3.242876,
3.428571, 1269, 3.410389,
3.714286, 1269, 3.574434,
4, 1269, 3.734555,
4.285714, 1269, 3.890373,
4.571429, 1269, 4.04157,
4.857143, 1269, 4.187895,
5.142857, 1269, 4.329156,
5.428571, 1269, 4.465213,
5.714286, 1269, 4.595975,
6, 1269, 4.721396,
6.285714, 1269, 4.841469,
6.571429, 1269, 4.956222,
6.857143, 1269, 5.065711,
7.142857, 1269, 5.170019,
7.428571, 1269, 5.26925,
7.714286, 1269, 5.363527,
8, 1269, 5.452986,
8.285714, 1269, 5.537775,
8.571428, 1269, 5.618053,
8.857142, 1269, 5.693983,
9.142858, 1269, 5.765733,
9.428572, 1269, 5.833475,
9.714286, 1269, 5.89738,
10, 1269, 5.95762,
10.28571, 1269, 6.014365,
10.57143, 1269, 6.067782,
10.85714, 1269, 6.118037,
11.14286, 1269, 6.165287,
11.42857, 1269, 6.209691,
11.71429, 1269, 6.251398,
12, 1269, 6.290553,
12.28571, 1269, 6.327298,
12.57143, 1269, 6.361765,
12.85714, 1269, 6.394085,
13.14286, 1269, 6.42438,
13.42857, 1269, 6.452768,
13.71429, 1269, 6.479361,
14, 1269, 6.504265
]);
var buf35 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf35);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc35 = gl.getUniformLocation(prog35,"mvMatrix");
var prMatLoc35 = gl.getUniformLocation(prog35,"prMatrix");
// ****** linestrip object 36 ******
var prog36  = gl.createProgram();
gl.attachShader(prog36, getShader( gl, "unnamed_chunk_3vshader36" ));
gl.attachShader(prog36, getShader( gl, "unnamed_chunk_3fshader36" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog36, 0, "aPos");
gl.bindAttribLocation(prog36, 1, "aCol");
gl.linkProgram(prog36);
var v=new Float32Array([
0, 1271, 1.37,
0.2857143, 1271, 1.532511,
0.5714286, 1271, 1.702299,
0.8571429, 1271, 1.878488,
1.142857, 1271, 2.06016,
1.428571, 1271, 2.246369,
1.714286, 1271, 2.436163,
2, 1271, 2.628599,
2.285714, 1271, 2.822755,
2.571429, 1271, 3.017746,
2.857143, 1271, 3.212731,
3.142857, 1271, 3.406922,
3.428571, 1271, 3.599587,
3.714286, 1271, 3.790062,
4, 1271, 3.977741,
4.285714, 1271, 4.16209,
4.571429, 1271, 4.342638,
4.857143, 1271, 4.518975,
5.142857, 1271, 4.69076,
5.428571, 1271, 4.857704,
5.714286, 1271, 5.019577,
6, 1271, 5.176201,
6.285714, 1271, 5.327445,
6.571429, 1271, 5.473222,
6.857143, 1271, 5.613483,
7.142857, 1271, 5.748218,
7.428571, 1271, 5.877444,
7.714286, 1271, 6.001208,
8, 1271, 6.119583,
8.285714, 1271, 6.232659,
8.571428, 1271, 6.340546,
8.857142, 1271, 6.443367,
9.142858, 1271, 6.541258,
9.428572, 1271, 6.634366,
9.714286, 1271, 6.722841,
10, 1271, 6.806844,
10.28571, 1271, 6.886535,
10.57143, 1271, 6.96208,
10.85714, 1271, 7.033643,
11.14286, 1271, 7.101389,
11.42857, 1271, 7.165483,
11.71429, 1271, 7.226085,
12, 1271, 7.283355,
12.28571, 1271, 7.337448,
12.57143, 1271, 7.388516,
12.85714, 1271, 7.436707,
13.14286, 1271, 7.482163,
13.42857, 1271, 7.525024,
13.71429, 1271, 7.565421,
14, 1271, 7.603484
]);
var buf36 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf36);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc36 = gl.getUniformLocation(prog36,"mvMatrix");
var prMatLoc36 = gl.getUniformLocation(prog36,"prMatrix");
// ****** linestrip object 37 ******
var prog37  = gl.createProgram();
gl.attachShader(prog37, getShader( gl, "unnamed_chunk_3vshader37" ));
gl.attachShader(prog37, getShader( gl, "unnamed_chunk_3fshader37" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog37, 0, "aPos");
gl.bindAttribLocation(prog37, 1, "aCol");
gl.linkProgram(prog37);
var v=new Float32Array([
0, 1299, 1.37,
0.2857143, 1299, 1.522901,
0.5714286, 1299, 1.680565,
0.8571429, 1299, 1.842002,
1.142857, 1299, 2.006223,
1.428571, 1299, 2.172259,
1.714286, 1299, 2.339181,
2, 1299, 2.506109,
2.285714, 1299, 2.672222,
2.571429, 1299, 2.836768,
2.857143, 1299, 2.999069,
3.142857, 1299, 3.15852,
3.428571, 1299, 3.314591,
3.714286, 1299, 3.46683,
4, 1299, 3.614856,
4.285714, 1299, 3.758354,
4.571429, 1299, 3.897077,
4.857143, 1299, 4.030838,
5.142857, 1299, 4.159503,
5.428571, 1299, 4.282988,
5.714286, 1299, 4.401256,
6, 1299, 4.514305,
6.285714, 1299, 4.622171,
6.571429, 1299, 4.724918,
6.857143, 1299, 4.822635,
7.142857, 1299, 4.915432,
7.428571, 1299, 5.003438,
7.714286, 1299, 5.086792,
8, 1299, 5.16565,
8.285714, 1299, 5.240171,
8.571428, 1299, 5.310521,
8.857142, 1299, 5.376871,
9.142858, 1299, 5.439392,
9.428572, 1299, 5.498258,
9.714286, 1299, 5.553638,
10, 1299, 5.605702,
10.28571, 1299, 5.654617,
10.57143, 1299, 5.700543,
10.85714, 1299, 5.743639,
11.14286, 1299, 5.784058,
11.42857, 1299, 5.821946,
11.71429, 1299, 5.857446,
12, 1299, 5.890693,
12.28571, 1299, 5.921818,
12.57143, 1299, 5.950946,
12.85714, 1299, 5.978194,
13.14286, 1299, 6.003677,
13.42857, 1299, 6.027501,
13.71429, 1299, 6.049767,
14, 1299, 6.070573
]);
var buf37 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf37);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc37 = gl.getUniformLocation(prog37,"mvMatrix");
var prMatLoc37 = gl.getUniformLocation(prog37,"prMatrix");
// ****** linestrip object 38 ******
var prog38  = gl.createProgram();
gl.attachShader(prog38, getShader( gl, "unnamed_chunk_3vshader38" ));
gl.attachShader(prog38, getShader( gl, "unnamed_chunk_3fshader38" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog38, 0, "aPos");
gl.bindAttribLocation(prog38, 1, "aCol");
gl.linkProgram(prog38);
var v=new Float32Array([
0, 1302, 1.37,
0.2857143, 1302, 1.504513,
0.5714286, 1302, 1.640818,
0.8571429, 1302, 1.778021,
1.142857, 1302, 1.915277,
1.428571, 1302, 2.051804,
1.714286, 1302, 2.186888,
2, 1302, 2.31989,
2.285714, 1302, 2.450249,
2.571429, 1302, 2.577482,
2.857143, 1302, 2.70118,
3.142857, 1302, 2.821009,
3.428571, 1302, 2.936703,
3.714286, 1302, 3.048059,
4, 1302, 3.154935,
4.285714, 1302, 3.257238,
4.571429, 1302, 3.354924,
4.857143, 1302, 3.447989,
5.142857, 1302, 3.536466,
5.428571, 1302, 3.620417,
5.714286, 1302, 3.699929,
6, 1302, 3.775112,
6.285714, 1302, 3.846092,
6.571429, 1302, 3.913006,
6.857143, 1302, 3.976005,
7.142857, 1302, 4.035245,
7.428571, 1302, 4.090887,
7.714286, 1302, 4.143093,
8, 1302, 4.192029,
8.285714, 1302, 4.237858,
8.571428, 1302, 4.280742,
8.857142, 1302, 4.320837,
9.142858, 1302, 4.3583,
9.428572, 1302, 4.393279,
9.714286, 1302, 4.425919,
10, 1302, 4.456358,
10.28571, 1302, 4.484732,
10.57143, 1302, 4.511166,
10.85714, 1302, 4.535783,
11.14286, 1302, 4.558697,
11.42857, 1302, 4.580018,
11.71429, 1302, 4.599849,
12, 1302, 4.618289,
12.28571, 1302, 4.635431,
12.57143, 1302, 4.65136,
12.85714, 1302, 4.666159,
13.14286, 1302, 4.679904,
13.42857, 1302, 4.692668,
13.71429, 1302, 4.704518,
14, 1302, 4.715518
]);
var buf38 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf38);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc38 = gl.getUniformLocation(prog38,"mvMatrix");
var prMatLoc38 = gl.getUniformLocation(prog38,"prMatrix");
// ****** linestrip object 39 ******
var prog39  = gl.createProgram();
gl.attachShader(prog39, getShader( gl, "unnamed_chunk_3vshader39" ));
gl.attachShader(prog39, getShader( gl, "unnamed_chunk_3fshader39" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog39, 0, "aPos");
gl.bindAttribLocation(prog39, 1, "aCol");
gl.linkProgram(prog39);
var v=new Float32Array([
0, 1321, 1.37,
0.2857143, 1321, 1.526687,
0.5714286, 1321, 1.688955,
0.8571429, 1321, 1.855826,
1.142857, 1321, 2.026308,
1.428571, 1321, 2.199419,
1.714286, 1321, 2.374199,
2, 1321, 2.549728,
2.285714, 1321, 2.725136,
2.571429, 1321, 2.899613,
2.857143, 1321, 3.072417,
3.142857, 1321, 3.242876,
3.428571, 1321, 3.410389,
3.714286, 1321, 3.574434,
4, 1321, 3.734555,
4.285714, 1321, 3.890373,
4.571429, 1321, 4.04157,
4.857143, 1321, 4.187895,
5.142857, 1321, 4.329156,
5.428571, 1321, 4.465213,
5.714286, 1321, 4.595975,
6, 1321, 4.721396,
6.285714, 1321, 4.841469,
6.571429, 1321, 4.956222,
6.857143, 1321, 5.065711,
7.142857, 1321, 5.170019,
7.428571, 1321, 5.26925,
7.714286, 1321, 5.363527,
8, 1321, 5.452986,
8.285714, 1321, 5.537775,
8.571428, 1321, 5.618053,
8.857142, 1321, 5.693983,
9.142858, 1321, 5.765733,
9.428572, 1321, 5.833475,
9.714286, 1321, 5.89738,
10, 1321, 5.95762,
10.28571, 1321, 6.014365,
10.57143, 1321, 6.067782,
10.85714, 1321, 6.118037,
11.14286, 1321, 6.165287,
11.42857, 1321, 6.209691,
11.71429, 1321, 6.251398,
12, 1321, 6.290553,
12.28571, 1321, 6.327298,
12.57143, 1321, 6.361765,
12.85714, 1321, 6.394085,
13.14286, 1321, 6.42438,
13.42857, 1321, 6.452768,
13.71429, 1321, 6.479361,
14, 1321, 6.504265
]);
var buf39 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf39);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc39 = gl.getUniformLocation(prog39,"mvMatrix");
var prMatLoc39 = gl.getUniformLocation(prog39,"prMatrix");
// ****** linestrip object 40 ******
var prog40  = gl.createProgram();
gl.attachShader(prog40, getShader( gl, "unnamed_chunk_3vshader40" ));
gl.attachShader(prog40, getShader( gl, "unnamed_chunk_3fshader40" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog40, 0, "aPos");
gl.bindAttribLocation(prog40, 1, "aCol");
gl.linkProgram(prog40);
var v=new Float32Array([
0, 1329, 1.37,
0.2857143, 1329, 1.514161,
0.5714286, 1329, 1.66152,
0.8571429, 1329, 1.811108,
1.142857, 1329, 1.96199,
1.428571, 1329, 2.11327,
1.714286, 1329, 2.264115,
2, 1329, 2.413754,
2.285714, 1329, 2.561493,
2.571429, 1329, 2.706709,
2.857143, 1329, 2.848863,
3.142857, 1329, 2.987489,
3.428571, 1329, 3.122196,
3.714286, 1329, 3.252666,
4, 1329, 3.378648,
4.285714, 1329, 3.499952,
4.571429, 1329, 3.616446,
4.857143, 1329, 3.728046,
5.142857, 1329, 3.834718,
5.428571, 1329, 3.936465,
5.714286, 1329, 4.033324,
6, 1329, 4.125364,
6.285714, 1329, 4.212678,
6.571429, 1329, 4.295379,
6.857143, 1329, 4.373598,
7.142857, 1329, 4.447477,
7.428571, 1329, 4.517171,
7.714286, 1329, 4.582841,
8, 1329, 4.644652,
8.285714, 1329, 4.702774,
8.571428, 1329, 4.757375,
8.857142, 1329, 4.808625,
9.142858, 1329, 4.856691,
9.428572, 1329, 4.901738,
9.714286, 1329, 4.943926,
10, 1329, 4.983411,
10.28571, 1329, 5.020345,
10.57143, 1329, 5.054873,
10.85714, 1329, 5.087136,
11.14286, 1329, 5.117269,
11.42857, 1329, 5.145398,
11.71429, 1329, 5.171647,
12, 1329, 5.196132,
12.28571, 1329, 5.218964,
12.57143, 1329, 5.240247,
12.85714, 1329, 5.260081,
13.14286, 1329, 5.278558,
13.42857, 1329, 5.295768,
13.71429, 1329, 5.311792,
14, 1329, 5.326711
]);
var buf40 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf40);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc40 = gl.getUniformLocation(prog40,"mvMatrix");
var prMatLoc40 = gl.getUniformLocation(prog40,"prMatrix");
// ****** linestrip object 41 ******
var prog41  = gl.createProgram();
gl.attachShader(prog41, getShader( gl, "unnamed_chunk_3vshader41" ));
gl.attachShader(prog41, getShader( gl, "unnamed_chunk_3fshader41" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog41, 0, "aPos");
gl.bindAttribLocation(prog41, 1, "aCol");
gl.linkProgram(prog41);
var v=new Float32Array([
0, 1335, 1.37,
0.2857143, 1335, 1.533488,
0.5714286, 1335, 1.704842,
0.8571429, 1335, 1.883262,
1.142857, 1335, 2.067889,
1.428571, 1335, 2.257832,
1.714286, 1335, 2.452177,
2, 1335, 2.650007,
2.285714, 1335, 2.850413,
2.571429, 1335, 3.05251,
2.857143, 1335, 3.255445,
3.142857, 1335, 3.458405,
3.428571, 1335, 3.660628,
3.714286, 1335, 3.861404,
4, 1335, 4.060082,
4.285714, 1335, 4.256072,
4.571429, 1335, 4.448841,
4.857143, 1335, 4.637921,
5.142857, 1335, 4.822902,
5.428571, 1335, 5.003433,
5.714286, 1335, 5.179217,
6, 1335, 5.350013,
6.285714, 1335, 5.515626,
6.571429, 1335, 5.675909,
6.857143, 1335, 5.830756,
7.142857, 1335, 5.980103,
7.428571, 1335, 6.123916,
7.714286, 1335, 6.262197,
8, 1335, 6.394973,
8.285714, 1335, 6.522297,
8.571428, 1335, 6.644244,
8.857142, 1335, 6.760904,
9.142858, 1335, 6.872387,
9.428572, 1335, 6.978815,
9.714286, 1335, 7.080317,
10, 1335, 7.177037,
10.28571, 1335, 7.269121,
10.57143, 1335, 7.356721,
10.85714, 1335, 7.439995,
11.14286, 1335, 7.519099,
11.42857, 1335, 7.594194,
11.71429, 1335, 7.665439,
12, 1335, 7.732991,
12.28571, 1335, 7.797007,
12.57143, 1335, 7.85764,
12.85714, 1335, 7.915043,
13.14286, 1335, 7.969362,
13.42857, 1335, 8.020741,
13.71429, 1335, 8.06932,
14, 1335, 8.115234
]);
var buf41 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf41);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc41 = gl.getUniformLocation(prog41,"mvMatrix");
var prMatLoc41 = gl.getUniformLocation(prog41,"prMatrix");
// ****** linestrip object 42 ******
var prog42  = gl.createProgram();
gl.attachShader(prog42, getShader( gl, "unnamed_chunk_3vshader42" ));
gl.attachShader(prog42, getShader( gl, "unnamed_chunk_3fshader42" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog42, 0, "aPos");
gl.bindAttribLocation(prog42, 1, "aCol");
gl.linkProgram(prog42);
var v=new Float32Array([
0, 1400, 1.37,
0.2857143, 1400, 1.527737,
0.5714286, 1400, 1.691305,
0.8571429, 1400, 1.859735,
1.142857, 1400, 2.032039,
1.428571, 1400, 2.207232,
1.714286, 1400, 2.384349,
2, 1400, 2.562462,
2.285714, 1400, 2.740687,
2.571429, 1400, 2.9182,
2.857143, 1400, 3.09424,
3.142857, 1400, 3.268114,
3.428571, 1400, 3.439204,
3.714286, 1400, 3.606961,
4, 1400, 3.770911,
4.285714, 1400, 3.93065,
4.571429, 1400, 4.085841,
4.857143, 1400, 4.236211,
5.142857, 1400, 4.381547,
5.428571, 1400, 4.521692,
5.714286, 1400, 4.656536,
6, 1400, 4.786018,
6.285714, 1400, 4.910116,
6.571429, 1400, 5.028844,
6.857143, 1400, 5.142247,
7.142857, 1400, 5.250397,
7.428571, 1400, 5.353389,
7.714286, 1400, 5.451339,
8, 1400, 5.544375,
8.285714, 1400, 5.632643,
8.571428, 1400, 5.716295,
8.857142, 1400, 5.795491,
9.142858, 1400, 5.870398,
9.428572, 1400, 5.941185,
9.714286, 1400, 6.008025,
10, 1400, 6.071087,
10.28571, 1400, 6.130543,
10.57143, 1400, 6.186561,
10.85714, 1400, 6.239306,
11.14286, 1400, 6.288942,
11.42857, 1400, 6.335626,
11.71429, 1400, 6.37951,
12, 1400, 6.420743,
12.28571, 1400, 6.459469,
12.57143, 1400, 6.495824,
12.85714, 1400, 6.52994,
13.14286, 1400, 6.561944,
13.42857, 1400, 6.591956,
13.71429, 1400, 6.620091,
14, 1400, 6.64646
]);
var buf42 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf42);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc42 = gl.getUniformLocation(prog42,"mvMatrix");
var prMatLoc42 = gl.getUniformLocation(prog42,"prMatrix");
// ****** points object 43 ******
var prog43  = gl.createProgram();
gl.attachShader(prog43, getShader( gl, "unnamed_chunk_3vshader43" ));
gl.attachShader(prog43, getShader( gl, "unnamed_chunk_3fshader43" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog43, 0, "aPos");
gl.bindAttribLocation(prog43, 1, "aCol");
gl.linkProgram(prog43);
var v=new Float32Array([
3.6, 1239, 4.5,
3.4, 1239, 3.5,
3.5, 1239, 4.5,
8.4, 1239, 4.5,
4, 1239, 4.5,
4.9, 1239, 3.5,
4.5, 1239, 4.5,
5.1, 1239, 4.5,
5.3, 1239, 4.5,
3.17, 1269, 2.5,
5.7, 1269, 4.5,
3.76, 1269, 4.5,
3.19, 1269, 4.5,
5.6, 1269, 4.5,
9.1, 1269, 4.5,
6.7, 1299, 3.5,
8, 1329, 2.5,
10.2, 1329, 3.5,
8.4, 1240, 4.5,
5.5, 1240, 4.5,
6.3, 1240, 4.5,
5.9, 1240, 5.5,
5.2, 1240, 5.5,
7.9, 1240, 5.5,
6.7, 1240, 5.5,
4.9, 1240, 3.5,
6, 1240, 5.5,
4.8, 1240, 3.5,
4.1, 1240, 3.5,
5.2, 1240, 4.5,
3.36, 1271, 4.5,
4.6, 1271, 4.5,
3.8, 1271, 3.5,
6.3, 1271, 5.5,
3.28, 1271, 2.5,
6.8, 1271, 4.5,
3.2, 1271, 3.5,
8.2, 1271, 5.5,
5.5, 1271, 4.5,
6.1, 1271, 4.5,
6.3, 1271, 4.5,
3.45, 1271, 3.5,
9.5, 1271, 5.5,
9, 1271, 5.5,
4, 1271, 4.5,
6, 1271, 4.5,
6.9, 1271, 5.5,
3.9, 1271, 3.5,
3.44, 1271, 2.5,
7.2, 1271, 4.5,
4.2, 1271, 4.5,
8.1, 1271, 5.5,
7.8, 1271, 4.5,
5.7, 1302, 3.5,
5.1, 1302, 3.5,
6.6, 1302, 3.5,
4.4, 1302, 4.5,
5.2, 1302, 3.5,
4.4, 1302, 4.5,
5.2, 1302, 4.5,
5.2, 1302, 3.5,
4.2, 1302, 3.5,
4.3, 1302, 3.5,
4.8, 1302, 3.5,
3.9, 1302, 3.5,
5.1, 1302, 4.5,
6.9, 1261, 6.5,
9.5, 1261, 6.5,
2.3, 1321, 3.5,
3.75, 1321, 4.5,
2.14, 1321, 2.5,
6.1, 1321, 3.5,
2.3, 1400, 2.5,
4.7, 1400, 3.5,
3.1, 1400, 2.5,
4.8, 1400, 3.5,
5.4, 1400, 4.5,
3.4, 1400, 4.5,
4.4, 1400, 4.5,
4.3, 1400, 2.5,
3.58, 1400, 2.5,
3.1, 1400, 2.5,
3.5, 1400, 2.5,
2.8, 1400, 2.5,
3.2, 1400, 2.5,
2.95, 1249, 2.5,
3.4, 1305, 4.5,
2.8, 1335, 2.5,
12.2, 1205, 6.5
]);
var buf43 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf43);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc43 = gl.getUniformLocation(prog43,"mvMatrix");
var prMatLoc43 = gl.getUniformLocation(prog43,"prMatrix");
// ****** points object 44 ******
var prog44  = gl.createProgram();
gl.attachShader(prog44, getShader( gl, "unnamed_chunk_3vshader44" ));
gl.attachShader(prog44, getShader( gl, "unnamed_chunk_3fshader44" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog44, 0, "aPos");
gl.bindAttribLocation(prog44, 1, "aCol");
gl.linkProgram(prog44);
var v=new Float32Array([
4, 1239, 3.5,
3.5, 1239, 2.5,
4.1, 1239, 3.5,
8.6, 1239, 4.5,
4.8, 1239, 4.5,
5.8, 1239, 4.5,
5.2, 1239, 5.5,
6.2, 1239, 6.5,
6.1, 1239, 6.5,
4.7, 1269, 5.5,
3.8, 1269, 4.5,
7.5, 1269, 5.5,
9.2, 1269, 4.5,
9, 1299, 5.5,
10.5, 1329, 3.5,
9.4, 1240, 6.5,
5.9, 1240, 4.5,
6.7, 1240, 6.5,
5.4, 1240, 5.5,
8.8, 1240, 7.5,
6.9, 1240, 5.5,
5, 1240, 4.5,
6.4, 1240, 4.5,
4.8, 1240, 4.5,
5.8, 1240, 6.5,
7.3, 1271, 7.5,
7.2, 1271, 5.5,
8.5, 1271, 5.5,
7.2, 1271, 5.5,
10.1, 1271, 6.5,
9.2, 1271, 7.5,
6.5, 1271, 6.5,
7.1, 1271, 6.5,
7.3, 1271, 4.5,
8.6, 1271, 5.5,
7.8, 1271, 5.5,
7.7, 1302, 3.5,
5.8, 1302, 3.5,
5.7, 1302, 4.5,
6.2, 1302, 4.5,
6.4, 1302, 4.5,
4.3, 1302, 3.5,
5, 1302, 3.5,
5.4, 1302, 4.5,
6.3, 1302, 4.5,
4.6, 1302, 4.5,
5.8, 1231, 4.5,
7.9, 1261, 7.5,
11.2, 1261, 8.5,
3.5, 1321, 2.5,
6.7, 1321, 4.5,
11, 1321, 5.5,
6.7, 1321, 5.5,
3.4, 1400, 2.5,
5, 1400, 3.5,
3.1, 1400, 2.5,
3.9, 1400, 4.5,
3.2, 1400, 2.5,
3.8, 1400, 3.5,
6, 1400, 5.5,
6.1, 1400, 5.5,
6, 1400, 4.5,
5.2, 1400, 4.5,
5, 1400, 3.5,
8.7, 1400, 4.5,
3.7, 1400, 2.5,
3.5, 1335, 2.5,
14, 1205, 10.5
]);
var buf44 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf44);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc44 = gl.getUniformLocation(prog44,"mvMatrix");
var prMatLoc44 = gl.getUniformLocation(prog44,"prMatrix");
// ****** lines object 45 ******
var prog45  = gl.createProgram();
gl.attachShader(prog45, getShader( gl, "unnamed_chunk_3vshader45" ));
gl.attachShader(prog45, getShader( gl, "unnamed_chunk_3fshader45" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog45, 0, "aPos");
gl.bindAttribLocation(prog45, 1, "aCol");
gl.linkProgram(prog45);
var v=new Float32Array([
0, 1202.075, 1.23305,
14, 1202.075, 1.23305,
0, 1202.075, 1.23305,
0, 1197.054, 0.9979525,
2, 1202.075, 1.23305,
2, 1197.054, 0.9979525,
4, 1202.075, 1.23305,
4, 1197.054, 0.9979525,
6, 1202.075, 1.23305,
6, 1197.054, 0.9979525,
8, 1202.075, 1.23305,
8, 1197.054, 0.9979525,
10, 1202.075, 1.23305,
10, 1197.054, 0.9979525,
12, 1202.075, 1.23305,
12, 1197.054, 0.9979525,
14, 1202.075, 1.23305,
14, 1197.054, 0.9979525
]);
var buf45 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf45);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc45 = gl.getUniformLocation(prog45,"mvMatrix");
var prMatLoc45 = gl.getUniformLocation(prog45,"prMatrix");
// ****** text object 46 ******
var prog46  = gl.createProgram();
gl.attachShader(prog46, getShader( gl, "unnamed_chunk_3vshader46" ));
gl.attachShader(prog46, getShader( gl, "unnamed_chunk_3fshader46" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog46, 0, "aPos");
gl.bindAttribLocation(prog46, 1, "aCol");
gl.linkProgram(prog46);
var texts = [
"0",
"2",
"4",
"6",
"8",
"10",
"12",
"14"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX46 = texinfo.canvasX;
var canvasY46 = texinfo.canvasY;
var ofsLoc46 = gl.getAttribLocation(prog46, "aOfs");
var texture46 = gl.createTexture();
var texLoc46 = gl.getAttribLocation(prog46, "aTexcoord");
var sampler46 = gl.getUniformLocation(prog46,"uSampler");
handleLoadedTexture(texture46, document.getElementById("unnamed_chunk_3textureCanvas"));
var v=new Float32Array([
0, 1187.011, 0.5277575, 0, -0.5, 0.5, 0.5,
0, 1187.011, 0.5277575, 1, -0.5, 0.5, 0.5,
0, 1187.011, 0.5277575, 1, 1.5, 0.5, 0.5,
0, 1187.011, 0.5277575, 0, 1.5, 0.5, 0.5,
2, 1187.011, 0.5277575, 0, -0.5, 0.5, 0.5,
2, 1187.011, 0.5277575, 1, -0.5, 0.5, 0.5,
2, 1187.011, 0.5277575, 1, 1.5, 0.5, 0.5,
2, 1187.011, 0.5277575, 0, 1.5, 0.5, 0.5,
4, 1187.011, 0.5277575, 0, -0.5, 0.5, 0.5,
4, 1187.011, 0.5277575, 1, -0.5, 0.5, 0.5,
4, 1187.011, 0.5277575, 1, 1.5, 0.5, 0.5,
4, 1187.011, 0.5277575, 0, 1.5, 0.5, 0.5,
6, 1187.011, 0.5277575, 0, -0.5, 0.5, 0.5,
6, 1187.011, 0.5277575, 1, -0.5, 0.5, 0.5,
6, 1187.011, 0.5277575, 1, 1.5, 0.5, 0.5,
6, 1187.011, 0.5277575, 0, 1.5, 0.5, 0.5,
8, 1187.011, 0.5277575, 0, -0.5, 0.5, 0.5,
8, 1187.011, 0.5277575, 1, -0.5, 0.5, 0.5,
8, 1187.011, 0.5277575, 1, 1.5, 0.5, 0.5,
8, 1187.011, 0.5277575, 0, 1.5, 0.5, 0.5,
10, 1187.011, 0.5277575, 0, -0.5, 0.5, 0.5,
10, 1187.011, 0.5277575, 1, -0.5, 0.5, 0.5,
10, 1187.011, 0.5277575, 1, 1.5, 0.5, 0.5,
10, 1187.011, 0.5277575, 0, 1.5, 0.5, 0.5,
12, 1187.011, 0.5277575, 0, -0.5, 0.5, 0.5,
12, 1187.011, 0.5277575, 1, -0.5, 0.5, 0.5,
12, 1187.011, 0.5277575, 1, 1.5, 0.5, 0.5,
12, 1187.011, 0.5277575, 0, 1.5, 0.5, 0.5,
14, 1187.011, 0.5277575, 0, -0.5, 0.5, 0.5,
14, 1187.011, 0.5277575, 1, -0.5, 0.5, 0.5,
14, 1187.011, 0.5277575, 1, 1.5, 0.5, 0.5,
14, 1187.011, 0.5277575, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<8; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23,
24, 25, 26, 24, 26, 27,
28, 29, 30, 28, 30, 31
]);
var buf46 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf46);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf46 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf46);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc46 = gl.getUniformLocation(prog46,"mvMatrix");
var prMatLoc46 = gl.getUniformLocation(prog46,"prMatrix");
var textScaleLoc46 = gl.getUniformLocation(prog46,"textScale");
// ****** lines object 47 ******
var prog47  = gl.createProgram();
gl.attachShader(prog47, getShader( gl, "unnamed_chunk_3vshader47" ));
gl.attachShader(prog47, getShader( gl, "unnamed_chunk_3fshader47" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog47, 0, "aPos");
gl.bindAttribLocation(prog47, 1, "aCol");
gl.linkProgram(prog47);
var v=new Float32Array([
-0.21, 1250, 1.23305,
-0.21, 1400, 1.23305,
-0.21, 1250, 1.23305,
-0.5705, 1250, 0.9979525,
-0.21, 1300, 1.23305,
-0.5705, 1300, 0.9979525,
-0.21, 1350, 1.23305,
-0.5705, 1350, 0.9979525,
-0.21, 1400, 1.23305,
-0.5705, 1400, 0.9979525
]);
var buf47 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf47);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc47 = gl.getUniformLocation(prog47,"mvMatrix");
var prMatLoc47 = gl.getUniformLocation(prog47,"prMatrix");
// ****** text object 48 ******
var prog48  = gl.createProgram();
gl.attachShader(prog48, getShader( gl, "unnamed_chunk_3vshader48" ));
gl.attachShader(prog48, getShader( gl, "unnamed_chunk_3fshader48" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog48, 0, "aPos");
gl.bindAttribLocation(prog48, 1, "aCol");
gl.linkProgram(prog48);
var texts = [
"1250",
"1300",
"1350",
"1400"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX48 = texinfo.canvasX;
var canvasY48 = texinfo.canvasY;
var ofsLoc48 = gl.getAttribLocation(prog48, "aOfs");
var texture48 = gl.createTexture();
var texLoc48 = gl.getAttribLocation(prog48, "aTexcoord");
var sampler48 = gl.getUniformLocation(prog48,"uSampler");
handleLoadedTexture(texture48, document.getElementById("unnamed_chunk_3textureCanvas"));
var v=new Float32Array([
-1.2915, 1250, 0.5277575, 0, -0.5, 0.5, 0.5,
-1.2915, 1250, 0.5277575, 1, -0.5, 0.5, 0.5,
-1.2915, 1250, 0.5277575, 1, 1.5, 0.5, 0.5,
-1.2915, 1250, 0.5277575, 0, 1.5, 0.5, 0.5,
-1.2915, 1300, 0.5277575, 0, -0.5, 0.5, 0.5,
-1.2915, 1300, 0.5277575, 1, -0.5, 0.5, 0.5,
-1.2915, 1300, 0.5277575, 1, 1.5, 0.5, 0.5,
-1.2915, 1300, 0.5277575, 0, 1.5, 0.5, 0.5,
-1.2915, 1350, 0.5277575, 0, -0.5, 0.5, 0.5,
-1.2915, 1350, 0.5277575, 1, -0.5, 0.5, 0.5,
-1.2915, 1350, 0.5277575, 1, 1.5, 0.5, 0.5,
-1.2915, 1350, 0.5277575, 0, 1.5, 0.5, 0.5,
-1.2915, 1400, 0.5277575, 0, -0.5, 0.5, 0.5,
-1.2915, 1400, 0.5277575, 1, -0.5, 0.5, 0.5,
-1.2915, 1400, 0.5277575, 1, 1.5, 0.5, 0.5,
-1.2915, 1400, 0.5277575, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<4; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15
]);
var buf48 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf48);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf48 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf48);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc48 = gl.getUniformLocation(prog48,"mvMatrix");
var prMatLoc48 = gl.getUniformLocation(prog48,"prMatrix");
var textScaleLoc48 = gl.getUniformLocation(prog48,"textScale");
// ****** lines object 49 ******
var prog49  = gl.createProgram();
gl.attachShader(prog49, getShader( gl, "unnamed_chunk_3vshader49" ));
gl.attachShader(prog49, getShader( gl, "unnamed_chunk_3fshader49" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog49, 0, "aPos");
gl.bindAttribLocation(prog49, 1, "aCol");
gl.linkProgram(prog49);
var v=new Float32Array([
-0.21, 1202.075, 2,
-0.21, 1202.075, 10,
-0.21, 1202.075, 2,
-0.5705, 1197.054, 2,
-0.21, 1202.075, 4,
-0.5705, 1197.054, 4,
-0.21, 1202.075, 6,
-0.5705, 1197.054, 6,
-0.21, 1202.075, 8,
-0.5705, 1197.054, 8,
-0.21, 1202.075, 10,
-0.5705, 1197.054, 10
]);
var buf49 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf49);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc49 = gl.getUniformLocation(prog49,"mvMatrix");
var prMatLoc49 = gl.getUniformLocation(prog49,"prMatrix");
// ****** text object 50 ******
var prog50  = gl.createProgram();
gl.attachShader(prog50, getShader( gl, "unnamed_chunk_3vshader50" ));
gl.attachShader(prog50, getShader( gl, "unnamed_chunk_3fshader50" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog50, 0, "aPos");
gl.bindAttribLocation(prog50, 1, "aCol");
gl.linkProgram(prog50);
var texts = [
"2",
"4",
"6",
"8",
"10"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX50 = texinfo.canvasX;
var canvasY50 = texinfo.canvasY;
var ofsLoc50 = gl.getAttribLocation(prog50, "aOfs");
var texture50 = gl.createTexture();
var texLoc50 = gl.getAttribLocation(prog50, "aTexcoord");
var sampler50 = gl.getUniformLocation(prog50,"uSampler");
handleLoadedTexture(texture50, document.getElementById("unnamed_chunk_3textureCanvas"));
var v=new Float32Array([
-1.2915, 1187.011, 2, 0, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 2, 1, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 2, 1, 1.5, 0.5, 0.5,
-1.2915, 1187.011, 2, 0, 1.5, 0.5, 0.5,
-1.2915, 1187.011, 4, 0, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 4, 1, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 4, 1, 1.5, 0.5, 0.5,
-1.2915, 1187.011, 4, 0, 1.5, 0.5, 0.5,
-1.2915, 1187.011, 6, 0, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 6, 1, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 6, 1, 1.5, 0.5, 0.5,
-1.2915, 1187.011, 6, 0, 1.5, 0.5, 0.5,
-1.2915, 1187.011, 8, 0, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 8, 1, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 8, 1, 1.5, 0.5, 0.5,
-1.2915, 1187.011, 8, 0, 1.5, 0.5, 0.5,
-1.2915, 1187.011, 10, 0, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 10, 1, -0.5, 0.5, 0.5,
-1.2915, 1187.011, 10, 1, 1.5, 0.5, 0.5,
-1.2915, 1187.011, 10, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<5; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19
]);
var buf50 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf50);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf50 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf50);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc50 = gl.getUniformLocation(prog50,"mvMatrix");
var prMatLoc50 = gl.getUniformLocation(prog50,"prMatrix");
var textScaleLoc50 = gl.getUniformLocation(prog50,"textScale");
// ****** lines object 51 ******
var prog51  = gl.createProgram();
gl.attachShader(prog51, getShader( gl, "unnamed_chunk_3vshader51" ));
gl.attachShader(prog51, getShader( gl, "unnamed_chunk_3fshader51" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog51, 0, "aPos");
gl.bindAttribLocation(prog51, 1, "aCol");
gl.linkProgram(prog51);
var v=new Float32Array([
-0.21, 1202.075, 1.23305,
-0.21, 1402.925, 1.23305,
-0.21, 1202.075, 10.63695,
-0.21, 1402.925, 10.63695,
-0.21, 1202.075, 1.23305,
-0.21, 1202.075, 10.63695,
-0.21, 1402.925, 1.23305,
-0.21, 1402.925, 10.63695,
-0.21, 1202.075, 1.23305,
14.21, 1202.075, 1.23305,
-0.21, 1202.075, 10.63695,
14.21, 1202.075, 10.63695,
-0.21, 1402.925, 1.23305,
14.21, 1402.925, 1.23305,
-0.21, 1402.925, 10.63695,
14.21, 1402.925, 10.63695,
14.21, 1202.075, 1.23305,
14.21, 1402.925, 1.23305,
14.21, 1202.075, 10.63695,
14.21, 1402.925, 10.63695,
14.21, 1202.075, 1.23305,
14.21, 1202.075, 10.63695,
14.21, 1402.925, 1.23305,
14.21, 1402.925, 10.63695
]);
var buf51 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf51);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc51 = gl.getUniformLocation(prog51,"mvMatrix");
var prMatLoc51 = gl.getUniformLocation(prog51,"prMatrix");
gl.enable(gl.DEPTH_TEST);
gl.depthFunc(gl.LEQUAL);
gl.clearDepth(1.0);
gl.clearColor(1,1,1,1);
var xOffs = 0, yOffs = 0, drag  = 0;
function multMV(M, v) {
return [M.m11*v[0] + M.m12*v[1] + M.m13*v[2] + M.m14*v[3],
M.m21*v[0] + M.m22*v[1] + M.m23*v[2] + M.m24*v[3],
M.m31*v[0] + M.m32*v[1] + M.m33*v[2] + M.m34*v[3],
M.m41*v[0] + M.m42*v[1] + M.m43*v[2] + M.m44*v[3]];
}
drawScene();
function drawScene(){
gl.depthMask(true);
gl.disable(gl.BLEND);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
// ***** subscene 1 ****
gl.viewport(0, 0, 504, 504);
gl.scissor(0, 0, 504, 504);
gl.clearColor(1, 1, 1, 1);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
var radius = 228.7905;
var distance = 1017.915;
var t = tan(fov[1]*PI/360);
var near = distance - radius;
var far = distance + radius;
var hlen = t*near;
var aspect = 1;
prMatrix.makeIdentity();
if (aspect > 1)
prMatrix.frustum(-hlen*aspect*zoom[1], hlen*aspect*zoom[1], 
-hlen*zoom[1], hlen*zoom[1], near, far);
else  
prMatrix.frustum(-hlen*zoom[1], hlen*zoom[1], 
-hlen*zoom[1]/aspect, hlen*zoom[1]/aspect, 
near, far);
mvMatrix.makeIdentity();
mvMatrix.translate( -7, -1302.5, -5.935 );
mvMatrix.scale( 11.20721, 0.5781773, 40.34958 );   
mvMatrix.multRight( userMatrix[1] );
mvMatrix.translate(-0, -0, -1017.915);
// ****** text object 9 *******
gl.useProgram(prog9);
gl.bindBuffer(gl.ARRAY_BUFFER, buf9);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf9);
gl.uniformMatrix4fv( prMatLoc9, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc9, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc9, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc9 );
gl.vertexAttribPointer(texLoc9, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture9);
gl.uniform1i( sampler9, 0);
gl.enableVertexAttribArray( ofsLoc9 );
gl.vertexAttribPointer(ofsLoc9, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
// ****** text object 10 *******
gl.useProgram(prog10);
gl.bindBuffer(gl.ARRAY_BUFFER, buf10);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf10);
gl.uniformMatrix4fv( prMatLoc10, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc10, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc10, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc10 );
gl.vertexAttribPointer(texLoc10, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture10);
gl.uniform1i( sampler10, 0);
gl.enableVertexAttribArray( ofsLoc10 );
gl.vertexAttribPointer(ofsLoc10, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
// ****** text object 11 *******
gl.useProgram(prog11);
gl.bindBuffer(gl.ARRAY_BUFFER, buf11);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf11);
gl.uniformMatrix4fv( prMatLoc11, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc11, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc11, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc11 );
gl.vertexAttribPointer(texLoc11, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture11);
gl.uniform1i( sampler11, 0);
gl.enableVertexAttribArray( ofsLoc11 );
gl.vertexAttribPointer(ofsLoc11, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
// ****** text object 12 *******
gl.useProgram(prog12);
gl.bindBuffer(gl.ARRAY_BUFFER, buf12);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf12);
gl.uniformMatrix4fv( prMatLoc12, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc12, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc12, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc12 );
gl.vertexAttribPointer(texLoc12, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture12);
gl.uniform1i( sampler12, 0);
gl.enableVertexAttribArray( ofsLoc12 );
gl.vertexAttribPointer(ofsLoc12, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
// ****** points object 13 *******
gl.useProgram(prog13);
gl.bindBuffer(gl.ARRAY_BUFFER, buf13);
gl.uniformMatrix4fv( prMatLoc13, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc13, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.POINTS, 0, 68);
// ****** points object 43 *******
gl.useProgram(prog43);
gl.bindBuffer(gl.ARRAY_BUFFER, buf43);
gl.uniformMatrix4fv( prMatLoc43, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc43, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.POINTS, 0, 89);
// ****** points object 44 *******
gl.useProgram(prog44);
gl.bindBuffer(gl.ARRAY_BUFFER, buf44);
gl.uniformMatrix4fv( prMatLoc44, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc44, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.POINTS, 0, 68);
// ****** lines object 45 *******
gl.useProgram(prog45);
gl.bindBuffer(gl.ARRAY_BUFFER, buf45);
gl.uniformMatrix4fv( prMatLoc45, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc45, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINES, 0, 18);
// ****** text object 46 *******
gl.useProgram(prog46);
gl.bindBuffer(gl.ARRAY_BUFFER, buf46);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf46);
gl.uniformMatrix4fv( prMatLoc46, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc46, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc46, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc46 );
gl.vertexAttribPointer(texLoc46, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture46);
gl.uniform1i( sampler46, 0);
gl.enableVertexAttribArray( ofsLoc46 );
gl.vertexAttribPointer(ofsLoc46, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 48, gl.UNSIGNED_SHORT, 0);
// ****** lines object 47 *******
gl.useProgram(prog47);
gl.bindBuffer(gl.ARRAY_BUFFER, buf47);
gl.uniformMatrix4fv( prMatLoc47, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc47, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINES, 0, 10);
// ****** text object 48 *******
gl.useProgram(prog48);
gl.bindBuffer(gl.ARRAY_BUFFER, buf48);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf48);
gl.uniformMatrix4fv( prMatLoc48, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc48, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc48, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc48 );
gl.vertexAttribPointer(texLoc48, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture48);
gl.uniform1i( sampler48, 0);
gl.enableVertexAttribArray( ofsLoc48 );
gl.vertexAttribPointer(ofsLoc48, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 24, gl.UNSIGNED_SHORT, 0);
// ****** lines object 49 *******
gl.useProgram(prog49);
gl.bindBuffer(gl.ARRAY_BUFFER, buf49);
gl.uniformMatrix4fv( prMatLoc49, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc49, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINES, 0, 12);
// ****** text object 50 *******
gl.useProgram(prog50);
gl.bindBuffer(gl.ARRAY_BUFFER, buf50);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf50);
gl.uniformMatrix4fv( prMatLoc50, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc50, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc50, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc50 );
gl.vertexAttribPointer(texLoc50, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture50);
gl.uniform1i( sampler50, 0);
gl.enableVertexAttribArray( ofsLoc50 );
gl.vertexAttribPointer(ofsLoc50, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 30, gl.UNSIGNED_SHORT, 0);
// ****** lines object 51 *******
gl.useProgram(prog51);
gl.bindBuffer(gl.ARRAY_BUFFER, buf51);
gl.uniformMatrix4fv( prMatLoc51, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc51, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINES, 0, 24);
// ***** Transparent objects next ****
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
// ****** points object 7 *******
gl.useProgram(prog7);
gl.bindBuffer(gl.ARRAY_BUFFER, buf7);
gl.uniformMatrix4fv( prMatLoc7, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc7, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.POINTS, 0, 89);
// ****** linestrip object 16 *******
gl.useProgram(prog16);
gl.bindBuffer(gl.ARRAY_BUFFER, buf16);
gl.uniformMatrix4fv( prMatLoc16, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc16, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 17 *******
gl.useProgram(prog17);
gl.bindBuffer(gl.ARRAY_BUFFER, buf17);
gl.uniformMatrix4fv( prMatLoc17, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc17, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 18 *******
gl.useProgram(prog18);
gl.bindBuffer(gl.ARRAY_BUFFER, buf18);
gl.uniformMatrix4fv( prMatLoc18, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc18, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 19 *******
gl.useProgram(prog19);
gl.bindBuffer(gl.ARRAY_BUFFER, buf19);
gl.uniformMatrix4fv( prMatLoc19, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc19, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 20 *******
gl.useProgram(prog20);
gl.bindBuffer(gl.ARRAY_BUFFER, buf20);
gl.uniformMatrix4fv( prMatLoc20, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc20, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 21 *******
gl.useProgram(prog21);
gl.bindBuffer(gl.ARRAY_BUFFER, buf21);
gl.uniformMatrix4fv( prMatLoc21, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc21, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 22 *******
gl.useProgram(prog22);
gl.bindBuffer(gl.ARRAY_BUFFER, buf22);
gl.uniformMatrix4fv( prMatLoc22, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc22, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 23 *******
gl.useProgram(prog23);
gl.bindBuffer(gl.ARRAY_BUFFER, buf23);
gl.uniformMatrix4fv( prMatLoc23, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc23, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 24 *******
gl.useProgram(prog24);
gl.bindBuffer(gl.ARRAY_BUFFER, buf24);
gl.uniformMatrix4fv( prMatLoc24, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc24, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 25 *******
gl.useProgram(prog25);
gl.bindBuffer(gl.ARRAY_BUFFER, buf25);
gl.uniformMatrix4fv( prMatLoc25, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc25, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 26 *******
gl.useProgram(prog26);
gl.bindBuffer(gl.ARRAY_BUFFER, buf26);
gl.uniformMatrix4fv( prMatLoc26, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc26, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 27 *******
gl.useProgram(prog27);
gl.bindBuffer(gl.ARRAY_BUFFER, buf27);
gl.uniformMatrix4fv( prMatLoc27, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc27, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 28 *******
gl.useProgram(prog28);
gl.bindBuffer(gl.ARRAY_BUFFER, buf28);
gl.uniformMatrix4fv( prMatLoc28, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc28, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 29 *******
gl.useProgram(prog29);
gl.bindBuffer(gl.ARRAY_BUFFER, buf29);
gl.uniformMatrix4fv( prMatLoc29, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc29, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 30 *******
gl.useProgram(prog30);
gl.bindBuffer(gl.ARRAY_BUFFER, buf30);
gl.uniformMatrix4fv( prMatLoc30, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc30, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 31 *******
gl.useProgram(prog31);
gl.bindBuffer(gl.ARRAY_BUFFER, buf31);
gl.uniformMatrix4fv( prMatLoc31, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc31, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 32 *******
gl.useProgram(prog32);
gl.bindBuffer(gl.ARRAY_BUFFER, buf32);
gl.uniformMatrix4fv( prMatLoc32, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc32, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 33 *******
gl.useProgram(prog33);
gl.bindBuffer(gl.ARRAY_BUFFER, buf33);
gl.uniformMatrix4fv( prMatLoc33, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc33, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 34 *******
gl.useProgram(prog34);
gl.bindBuffer(gl.ARRAY_BUFFER, buf34);
gl.uniformMatrix4fv( prMatLoc34, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc34, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 35 *******
gl.useProgram(prog35);
gl.bindBuffer(gl.ARRAY_BUFFER, buf35);
gl.uniformMatrix4fv( prMatLoc35, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc35, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 36 *******
gl.useProgram(prog36);
gl.bindBuffer(gl.ARRAY_BUFFER, buf36);
gl.uniformMatrix4fv( prMatLoc36, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc36, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 37 *******
gl.useProgram(prog37);
gl.bindBuffer(gl.ARRAY_BUFFER, buf37);
gl.uniformMatrix4fv( prMatLoc37, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc37, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 38 *******
gl.useProgram(prog38);
gl.bindBuffer(gl.ARRAY_BUFFER, buf38);
gl.uniformMatrix4fv( prMatLoc38, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc38, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 39 *******
gl.useProgram(prog39);
gl.bindBuffer(gl.ARRAY_BUFFER, buf39);
gl.uniformMatrix4fv( prMatLoc39, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc39, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 40 *******
gl.useProgram(prog40);
gl.bindBuffer(gl.ARRAY_BUFFER, buf40);
gl.uniformMatrix4fv( prMatLoc40, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc40, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 41 *******
gl.useProgram(prog41);
gl.bindBuffer(gl.ARRAY_BUFFER, buf41);
gl.uniformMatrix4fv( prMatLoc41, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc41, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 42 *******
gl.useProgram(prog42);
gl.bindBuffer(gl.ARRAY_BUFFER, buf42);
gl.uniformMatrix4fv( prMatLoc42, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc42, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
gl.flush ();
}
var vpx0 = {
1: 0
};
var vpy0 = {
1: 0
};
var vpWidths = {
1: 504
};
var vpHeights = {
1: 504
};
var activeModel = {
1: 1
};
var activeProjection = {
1: 1
};
var listeners = {
1: [ 1 ]
};
var whichSubscene = function(coords){
if (0 <= coords.x && coords.x <= 504 && 0 <= coords.y && coords.y <= 504) return(1);
return(1);
}
var translateCoords = function(subsceneid, coords){
return {x:coords.x - vpx0[subsceneid], y:coords.y - vpy0[subsceneid]};
}
var vlen = function(v) {
return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2])
}
var xprod = function(a, b) {
return [a[1]*b[2] - a[2]*b[1],
a[2]*b[0] - a[0]*b[2],
a[0]*b[1] - a[1]*b[0]];
}
var screenToVector = function(x, y) {
var width = vpWidths[activeSubscene];
var height = vpHeights[activeSubscene];
var radius = max(width, height)/2.0;
var cx = width/2.0;
var cy = height/2.0;
var px = (x-cx)/radius;
var py = (y-cy)/radius;
var plen = sqrt(px*px+py*py);
if (plen > 1.e-6) { 
px = px/plen;
py = py/plen;
}
var angle = (SQRT2 - plen)/SQRT2*PI/2;
var z = sin(angle);
var zlen = sqrt(1.0 - z*z);
px = px * zlen;
py = py * zlen;
return [px, py, z];
}
var rotBase;
var trackballdown = function(x,y) {
rotBase = screenToVector(x, y);
var l = listeners[activeModel[activeSubscene]];
saveMat = new Object();
for (var i = 0; i < l.length; i++) 
saveMat[l[i]] = new CanvasMatrix4(userMatrix[l[i]]);
}
var trackballmove = function(x,y) {
var rotCurrent = screenToVector(x,y);
var dot = rotBase[0]*rotCurrent[0] + 
rotBase[1]*rotCurrent[1] + 
rotBase[2]*rotCurrent[2];
var angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180./PI;
var axis = xprod(rotBase, rotCurrent);
var l = listeners[activeModel[activeSubscene]];
for (i = 0; i < l.length; i++) {
userMatrix[l[i]].load(saveMat[l[i]]);
userMatrix[l[i]].rotate(angle, axis[0], axis[1], axis[2]);
}
drawScene();
}
var y0zoom = 0;
var zoom0 = 0;
var zoomdown = function(x, y) {
y0zoom = y;
zoom0 = new Object();
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
zoom0[l[i]] = log(zoom[l[i]]);
}
var zoommove = function(x, y) {
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
zoom[l[i]] = exp(zoom0[l[i]] + (y-y0zoom)/height);
drawScene();
}
var y0fov = 0;
var fov0 = 1;
var fovdown = function(x, y) {
y0fov = y;
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
fov0 = fov[l[i]];
}
var fovmove = function(x, y) {
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
fov[l[i]] = max(1, min(179, fov0[l[i]] + 180*(y-y0fov)/height));
drawScene();
}
var mousedown = [trackballdown, zoomdown, fovdown];
var mousemove = [trackballmove, zoommove, fovmove];
function relMouseCoords(event){
var totalOffsetX = 0;
var totalOffsetY = 0;
var currentElement = canvas;
do{
totalOffsetX += currentElement.offsetLeft;
totalOffsetY += currentElement.offsetTop;
currentElement = currentElement.offsetParent;
}
while(currentElement)
var canvasX = event.pageX - totalOffsetX;
var canvasY = event.pageY - totalOffsetY;
return {x:canvasX, y:canvasY}
}
canvas.onmousedown = function ( ev ){
if (!ev.which) // Use w3c defns in preference to MS
switch (ev.button) {
case 0: ev.which = 1; break;
case 1: 
case 4: ev.which = 2; break;
case 2: ev.which = 3;
}
drag = ev.which;
var f = mousedown[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height-coords.y;
activeSubscene = whichSubscene(coords);
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y); 
ev.preventDefault();
}
}    
canvas.onmouseup = function ( ev ){	
drag = 0;
}
canvas.onmouseout = canvas.onmouseup;
canvas.onmousemove = function ( ev ){
if ( drag == 0 ) return;
var f = mousemove[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height - coords.y;
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
}
}
var wheelHandler = function(ev) {
var del = 1.1;
if (ev.shiftKey) del = 1.01;
var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
zoom[l[i]] *= ds;
drawScene();
ev.preventDefault();
};
canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
canvas.addEventListener("mousewheel", wheelHandler, false);
}
</script>
<canvas id="unnamed_chunk_3canvas" width="1" height="1"></canvas> 
<p id="unnamed_chunk_3debug">
You must enable Javascript to view this page properly.</p>
<script>unnamed_chunk_3webGLStart();</script>

## ABBA fits:
<canvas id="unnamed_chunk_4textureCanvas" style="display: none;" width="256" height="256">
Your browser does not support the HTML5 canvas element.</canvas>
<!-- ****** points object 52 ****** -->
<script id="unnamed_chunk_4vshader52" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
gl_PointSize = 3.;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader52" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** text object 54 ****** -->
<script id="unnamed_chunk_4vshader54" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_4fshader54" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** text object 55 ****** -->
<script id="unnamed_chunk_4vshader55" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_4fshader55" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** text object 56 ****** -->
<script id="unnamed_chunk_4vshader56" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_4fshader56" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** text object 57 ****** -->
<script id="unnamed_chunk_4vshader57" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_4fshader57" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** points object 58 ****** -->
<script id="unnamed_chunk_4vshader58" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
gl_PointSize = 3.;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader58" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 61 ****** -->
<script id="unnamed_chunk_4vshader61" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader61" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 62 ****** -->
<script id="unnamed_chunk_4vshader62" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader62" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 63 ****** -->
<script id="unnamed_chunk_4vshader63" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader63" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 64 ****** -->
<script id="unnamed_chunk_4vshader64" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader64" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 65 ****** -->
<script id="unnamed_chunk_4vshader65" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader65" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 66 ****** -->
<script id="unnamed_chunk_4vshader66" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader66" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 67 ****** -->
<script id="unnamed_chunk_4vshader67" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader67" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 68 ****** -->
<script id="unnamed_chunk_4vshader68" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader68" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 69 ****** -->
<script id="unnamed_chunk_4vshader69" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader69" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 70 ****** -->
<script id="unnamed_chunk_4vshader70" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader70" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 71 ****** -->
<script id="unnamed_chunk_4vshader71" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader71" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 72 ****** -->
<script id="unnamed_chunk_4vshader72" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader72" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 73 ****** -->
<script id="unnamed_chunk_4vshader73" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader73" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 74 ****** -->
<script id="unnamed_chunk_4vshader74" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader74" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 75 ****** -->
<script id="unnamed_chunk_4vshader75" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader75" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 76 ****** -->
<script id="unnamed_chunk_4vshader76" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader76" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 77 ****** -->
<script id="unnamed_chunk_4vshader77" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader77" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 78 ****** -->
<script id="unnamed_chunk_4vshader78" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader78" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 79 ****** -->
<script id="unnamed_chunk_4vshader79" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader79" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 80 ****** -->
<script id="unnamed_chunk_4vshader80" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader80" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 81 ****** -->
<script id="unnamed_chunk_4vshader81" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader81" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 82 ****** -->
<script id="unnamed_chunk_4vshader82" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader82" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 83 ****** -->
<script id="unnamed_chunk_4vshader83" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader83" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 84 ****** -->
<script id="unnamed_chunk_4vshader84" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader84" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 85 ****** -->
<script id="unnamed_chunk_4vshader85" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader85" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 86 ****** -->
<script id="unnamed_chunk_4vshader86" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader86" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 87 ****** -->
<script id="unnamed_chunk_4vshader87" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader87" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 88 ****** -->
<script id="unnamed_chunk_4vshader88" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader88" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 89 ****** -->
<script id="unnamed_chunk_4vshader89" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader89" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 90 ****** -->
<script id="unnamed_chunk_4vshader90" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader90" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 91 ****** -->
<script id="unnamed_chunk_4vshader91" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader91" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 92 ****** -->
<script id="unnamed_chunk_4vshader92" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader92" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 93 ****** -->
<script id="unnamed_chunk_4vshader93" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader93" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 94 ****** -->
<script id="unnamed_chunk_4vshader94" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader94" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 95 ****** -->
<script id="unnamed_chunk_4vshader95" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader95" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 96 ****** -->
<script id="unnamed_chunk_4vshader96" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader96" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 97 ****** -->
<script id="unnamed_chunk_4vshader97" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader97" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 98 ****** -->
<script id="unnamed_chunk_4vshader98" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader98" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 99 ****** -->
<script id="unnamed_chunk_4vshader99" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader99" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 100 ****** -->
<script id="unnamed_chunk_4vshader100" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader100" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 101 ****** -->
<script id="unnamed_chunk_4vshader101" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader101" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 102 ****** -->
<script id="unnamed_chunk_4vshader102" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader102" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 103 ****** -->
<script id="unnamed_chunk_4vshader103" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader103" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 104 ****** -->
<script id="unnamed_chunk_4vshader104" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader104" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 105 ****** -->
<script id="unnamed_chunk_4vshader105" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader105" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 106 ****** -->
<script id="unnamed_chunk_4vshader106" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader106" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 107 ****** -->
<script id="unnamed_chunk_4vshader107" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader107" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 108 ****** -->
<script id="unnamed_chunk_4vshader108" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader108" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 109 ****** -->
<script id="unnamed_chunk_4vshader109" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader109" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 110 ****** -->
<script id="unnamed_chunk_4vshader110" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader110" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 111 ****** -->
<script id="unnamed_chunk_4vshader111" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader111" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 112 ****** -->
<script id="unnamed_chunk_4vshader112" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader112" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 113 ****** -->
<script id="unnamed_chunk_4vshader113" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader113" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 114 ****** -->
<script id="unnamed_chunk_4vshader114" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader114" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 115 ****** -->
<script id="unnamed_chunk_4vshader115" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader115" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 116 ****** -->
<script id="unnamed_chunk_4vshader116" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader116" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 117 ****** -->
<script id="unnamed_chunk_4vshader117" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader117" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 118 ****** -->
<script id="unnamed_chunk_4vshader118" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader118" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 119 ****** -->
<script id="unnamed_chunk_4vshader119" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader119" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 120 ****** -->
<script id="unnamed_chunk_4vshader120" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader120" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 121 ****** -->
<script id="unnamed_chunk_4vshader121" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader121" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 122 ****** -->
<script id="unnamed_chunk_4vshader122" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader122" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 123 ****** -->
<script id="unnamed_chunk_4vshader123" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader123" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 124 ****** -->
<script id="unnamed_chunk_4vshader124" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader124" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 125 ****** -->
<script id="unnamed_chunk_4vshader125" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader125" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 126 ****** -->
<script id="unnamed_chunk_4vshader126" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader126" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 127 ****** -->
<script id="unnamed_chunk_4vshader127" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader127" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 128 ****** -->
<script id="unnamed_chunk_4vshader128" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader128" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 129 ****** -->
<script id="unnamed_chunk_4vshader129" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader129" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 130 ****** -->
<script id="unnamed_chunk_4vshader130" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader130" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 131 ****** -->
<script id="unnamed_chunk_4vshader131" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader131" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** linestrip object 132 ****** -->
<script id="unnamed_chunk_4vshader132" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader132" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** points object 133 ****** -->
<script id="unnamed_chunk_4vshader133" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
gl_PointSize = 3.;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader133" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** points object 134 ****** -->
<script id="unnamed_chunk_4vshader134" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
gl_PointSize = 3.;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader134" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** lines object 135 ****** -->
<script id="unnamed_chunk_4vshader135" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader135" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** text object 136 ****** -->
<script id="unnamed_chunk_4vshader136" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_4fshader136" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** lines object 137 ****** -->
<script id="unnamed_chunk_4vshader137" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader137" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** text object 138 ****** -->
<script id="unnamed_chunk_4vshader138" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_4fshader138" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** lines object 139 ****** -->
<script id="unnamed_chunk_4vshader139" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader139" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<!-- ****** text object 140 ****** -->
<script id="unnamed_chunk_4vshader140" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
attribute vec2 aTexcoord;
varying vec2 vTexcoord;
uniform vec2 textScale;
attribute vec2 aOfs;
void main(void) {
vCol = aCol;
vTexcoord = aTexcoord;
vec4 pos = prMatrix * mvMatrix * vec4(aPos, 1.);
pos = pos/pos.w;
gl_Position = pos + vec4(aOfs*textScale, 0.,0.);
}
</script>
<script id="unnamed_chunk_4fshader140" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
varying vec2 vTexcoord;
uniform sampler2D uSampler;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
vec4 textureColor = lighteffect*texture2D(uSampler, vTexcoord);
if (textureColor.a < 0.1)
discard;
else
gl_FragColor = textureColor;
}
</script> 
<!-- ****** lines object 141 ****** -->
<script id="unnamed_chunk_4vshader141" type="x-shader/x-vertex">
attribute vec3 aPos;
attribute vec4 aCol;
uniform mat4 mvMatrix;
uniform mat4 prMatrix;
varying vec4 vCol;
varying vec4 vPosition;
void main(void) {
vPosition = mvMatrix * vec4(aPos, 1.);
gl_Position = prMatrix * vPosition;
vCol = aCol;
}
</script>
<script id="unnamed_chunk_4fshader141" type="x-shader/x-fragment"> 
#ifdef GL_ES
precision highp float;
#endif
varying vec4 vCol; // carries alpha
varying vec4 vPosition;
void main(void) {
vec4 colDiff = vCol;
vec4 lighteffect = colDiff;
gl_FragColor = lighteffect;
}
</script> 
<script type="text/javascript">
function unnamed_chunk_4webGLStart() {
var debug = function(msg) {
document.getElementById("unnamed_chunk_4debug").innerHTML = msg;
}
debug("");
var canvas = document.getElementById("unnamed_chunk_4canvas");
if (!window.WebGLRenderingContext){
debug(" Your browser does not support WebGL. See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var gl;
try {
// Try to grab the standard context. If it fails, fallback to experimental.
gl = canvas.getContext("webgl") 
|| canvas.getContext("experimental-webgl");
}
catch(e) {}
if ( !gl ) {
debug(" Your browser appears to support WebGL, but did not create a WebGL context.  See <a href=\"http://get.webgl.org\">http://get.webgl.org</a>");
return;
}
var width = 505;  var height = 505;
canvas.width = width;   canvas.height = height;
var prMatrix = new CanvasMatrix4();
var mvMatrix = new CanvasMatrix4();
var normMatrix = new CanvasMatrix4();
var saveMat = new Object();
var distance;
var posLoc = 0;
var colLoc = 1;
var zoom = new Object();
var fov = new Object();
var userMatrix = new Object();
var activeSubscene = 1;
zoom[1] = 1;
fov[1] = 30;
userMatrix[1] = new CanvasMatrix4();
userMatrix[1].load([
1, 0, 0, 0,
0, 0.3420201, -0.9396926, 0,
0, 0.9396926, 0.3420201, 0,
0, 0, 0, 1
]);
function getPowerOfTwo(value) {
var pow = 1;
while(pow<value) {
pow *= 2;
}
return pow;
}
function handleLoadedTexture(texture, textureCanvas) {
gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, true);
gl.bindTexture(gl.TEXTURE_2D, texture);
gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, textureCanvas);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST);
gl.generateMipmap(gl.TEXTURE_2D);
gl.bindTexture(gl.TEXTURE_2D, null);
}
function loadImageToTexture(filename, texture) {   
var canvas = document.getElementById("unnamed_chunk_4textureCanvas");
var ctx = canvas.getContext("2d");
var image = new Image();
image.onload = function() {
var w = image.width;
var h = image.height;
var canvasX = getPowerOfTwo(w);
var canvasY = getPowerOfTwo(h);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.imageSmoothingEnabled = true;
ctx.drawImage(image, 0, 0, canvasX, canvasY);
handleLoadedTexture(texture, canvas);
drawScene();
}
image.src = filename;
}  	   
function drawTextToCanvas(text, cex) {
var canvasX, canvasY;
var textX, textY;
var textHeight = 20 * cex;
var textColour = "white";
var fontFamily = "Arial";
var backgroundColour = "rgba(0,0,0,0)";
var canvas = document.getElementById("unnamed_chunk_4textureCanvas");
var ctx = canvas.getContext("2d");
ctx.font = textHeight+"px "+fontFamily;
canvasX = 1;
var widths = [];
for (var i = 0; i < text.length; i++)  {
widths[i] = ctx.measureText(text[i]).width;
canvasX = (widths[i] > canvasX) ? widths[i] : canvasX;
}	  
canvasX = getPowerOfTwo(canvasX);
var offset = 2*textHeight; // offset to first baseline
var skip = 2*textHeight;   // skip between baselines	  
canvasY = getPowerOfTwo(offset + text.length*skip);
canvas.width = canvasX;
canvas.height = canvasY;
ctx.fillStyle = backgroundColour;
ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
ctx.fillStyle = textColour;
ctx.textAlign = "left";
ctx.textBaseline = "alphabetic";
ctx.font = textHeight+"px "+fontFamily;
for(var i = 0; i < text.length; i++) {
textY = i*skip + offset;
ctx.fillText(text[i], 0,  textY);
}
return {canvasX:canvasX, canvasY:canvasY,
widths:widths, textHeight:textHeight,
offset:offset, skip:skip};
}
// ****** points object 52 ******
var prog52  = gl.createProgram();
gl.attachShader(prog52, getShader( gl, "unnamed_chunk_4vshader52" ));
gl.attachShader(prog52, getShader( gl, "unnamed_chunk_4fshader52" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog52, 0, "aPos");
gl.bindAttribLocation(prog52, 1, "aCol");
gl.linkProgram(prog52);
var v=new Float32Array([
6.1, 1239, 3.808721,
5.4, 1239, 3.55648,
4.2, 1239, 3.092883,
1.2, 1239, 1.846597,
8, 1239, 4.414695,
3.8, 1239, 2.931146,
2.7, 1239, 2.474384,
5.5, 1239, 3.593401,
3.7, 1239, 2.890264,
2.9, 1239, 2.558318,
9.1, 1239, 4.710975,
2.2, 1239, 2.263968,
0.8, 1239, 1.683608,
4.1, 1239, 3.052736,
0.7, 1239, 1.643412,
0.9, 1239, 1.724041,
1.9, 1239, 2.137865,
8.7, 1239, 4.607821,
1.6, 1239, 2.012345,
1.1, 1239, 1.805551,
3.1, 1239, 2.641967,
6.2, 1239, 3.843537,
2.6, 1239, 2.43234,
2.3, 1239, 2.306064,
2.7, 1239, 2.474384,
1.5, 1239, 1.970704,
1.2, 1239, 1.846597,
8.9, 1239, 4.660045,
5.8, 1239, 3.702415,
5, 1239, 3.406004,
9.1, 1239, 4.710975,
7.9, 1239, 4.38578,
5.9, 1239, 3.738156,
6.8, 1239, 4.045751,
8.6, 1239, 4.58122,
5.6, 1239, 3.630033,
9.2, 1239, 4.735958,
7.3, 1239, 4.205292,
5.3, 1239, 3.519274,
6, 1239, 3.773592,
6, 1239, 3.773592,
6.5, 1239, 3.946091,
9.3, 1239, 4.760623,
5.5, 1239, 3.593401,
7.7, 1239, 4.326951,
6.4, 1269, 3.912225,
8, 1269, 4.414695,
3, 1269, 2.600184,
2.43, 1269, 2.360798,
5.7, 1269, 3.666373,
2.72, 1269, 2.482787,
5.5, 1269, 3.593401,
1.42, 1269, 1.937481,
0.86, 1269, 1.707841,
3.71, 1269, 2.89436,
3.8, 1269, 2.931146,
16.5, 1269, 5.856758,
13.6, 1269, 5.552362,
2.82, 1269, 2.524773,
10.8, 1269, 5.093699,
2.64, 1269, 2.449162,
7.9, 1269, 4.38578,
9.8, 1269, 4.879227,
11.2, 1269, 5.171422,
3.3, 1269, 2.725235,
1.883, 1269, 2.130733,
1.97, 1269, 2.167252,
2.92, 1269, 2.566698,
5.7, 1269, 3.666373,
7.5, 1269, 4.266788,
6.6, 1269, 3.979635,
3.44, 1269, 2.783246,
2.86, 1269, 2.541551,
1.45, 1269, 1.94993,
9.9, 1269, 4.902018,
4.3, 1269, 3.132824,
2.82, 1269, 2.524773,
3.07, 1269, 2.629442,
4.5, 1269, 3.212057,
7.6, 1269, 4.297036,
4.8, 1269, 3.329169,
5.4, 1269, 3.55648,
9.4, 1269, 4.78497,
9.7, 1269, 4.856128,
6.6, 1269, 3.979635,
2.88, 1269, 2.549936,
9.8, 1269, 4.879227,
0.9, 1269, 1.724041,
5.9, 1269, 3.738156,
6.5, 1269, 3.946091,
6.5, 1299, 3.946091,
16, 1299, 5.814013,
13.2, 1299, 5.498154,
7.9, 1299, 4.38578,
7.2, 1299, 4.174046,
3, 1299, 2.600184,
15.6, 1299, 5.777175,
14.2, 1299, 5.627533,
7.1, 1299, 4.142467,
4.1, 1299, 3.052736,
4, 1299, 3.012391,
4.2, 1299, 3.092883,
7.2, 1299, 4.174046,
3.6, 1299, 2.849222,
10, 1299, 4.924505,
6.3, 1299, 3.87804,
2.4, 1299, 2.348167,
3, 1329, 2.600184,
16.2, 1329, 5.831539,
11.5, 1329, 5.226844,
7.1, 1329, 4.142467,
3.7, 1329, 2.890264,
5.67, 1329, 3.655502,
2.5, 1329, 2.390264,
2.1, 1329, 2.221893,
2.1, 1329, 2.221893,
2.3, 1329, 2.306064,
12.8, 1329, 5.440469,
2.5, 1329, 2.390264,
7.9, 1329, 4.38578,
15.3, 1329, 5.747912,
1.49, 1329, 1.966547,
2.9, 1329, 2.558318,
3, 1329, 2.600184,
4.5, 1329, 3.212057,
4.8, 1329, 3.329169,
6.8, 1329, 4.045751,
3.15, 1329, 2.662823,
4.4, 1329, 3.172551,
4.9, 1329, 3.367715,
5.2, 1329, 3.48179,
7.2, 1329, 4.174046,
5.1, 1329, 3.444031,
3.46, 1329, 2.791512,
4.4, 1329, 3.172551,
3.08, 1329, 2.633618,
4.4, 1329, 3.172551,
2.66, 1329, 2.457571,
4.5, 1329, 3.212057,
21.4, 1329, 6.129349,
3.74, 1329, 2.906637,
2.1358, 1329, 2.236953,
2.33125, 1329, 2.319221,
1.8277, 1329, 2.107546,
4.6, 1329, 3.251333,
4.9, 1329, 3.367715,
3.47, 1329, 2.795643,
4.8, 1329, 3.329169,
2.37, 1329, 2.335536,
7.2, 1360, 1.422438,
5.6, 1360, 1.41682,
2.3, 1360, 1.396335,
17.3, 1240, 7.204096,
13.9, 1240, 6.672803,
3.2, 1240, 2.818919,
4.7, 1240, 3.539585,
4.6, 1240, 3.492154,
13.2, 1240, 6.528714,
6.8, 1240, 4.488723,
8.2, 1240, 5.052943,
2.8, 1240, 2.626193,
4, 1240, 3.205083,
3.7, 1240, 3.060456,
4.1, 1240, 3.253169,
2.5, 1240, 2.482524,
14.8, 1240, 6.839077,
7.2, 1240, 4.65632,
10.6, 1240, 5.865368,
14.8, 1240, 6.839077,
3.9, 1240, 3.156928,
4.8, 1240, 3.586871,
3.3, 1240, 2.867216,
3.6, 1240, 3.012164,
8.8, 1240, 5.274768,
3.5, 1240, 2.963851,
4, 1240, 3.205083,
13.2, 1240, 6.528714,
16.9, 1240, 7.154194,
5.8, 1240, 4.049666,
8.9, 1240, 5.310531,
9.3, 1240, 5.450103,
14, 1240, 6.692305,
9.7, 1240, 5.584104,
2.7, 1240, 2.578197,
9.1, 1271, 5.457282,
6.2, 1271, 4.267953,
4.7, 1271, 3.56315,
16.1, 1271, 7.203753,
8.9, 1271, 5.384143,
10.1, 1271, 5.802094,
2.989, 1271, 2.727215,
4.6, 1271, 3.514783,
6.9, 1271, 4.578881,
3.23, 1271, 2.845043,
11.8, 1271, 6.309481,
9.8, 1271, 5.702307,
5, 1271, 3.707438,
8.5, 1271, 5.233721,
3.96, 1271, 3.202885,
18.1, 1271, 7.470751,
15.6, 1271, 7.12424,
8.1, 1271, 5.077841,
4.9, 1271, 3.659488,
6.4, 1271, 4.35815,
11.7, 1302, 4.804914,
9.3, 1302, 4.394416,
10.9, 1302, 4.684296,
7.2, 1302, 3.901392,
6.5, 1302, 3.706293,
3.6, 1302, 2.741562,
11.9, 1302, 4.832771,
10.8, 1302, 4.668139,
7.6, 1302, 4.005861,
3.226, 1302, 2.602012,
9.5, 1302, 4.43447,
10.2, 1302, 4.565877,
8.2, 1302, 4.153095,
2.9, 1302, 2.478504,
7.9, 1302, 4.080887,
11.2, 1302, 4.731298,
9.8, 1302, 4.492435,
8.5, 1302, 4.22252,
5.1, 1302, 3.270008,
4.1, 1302, 2.923784,
16.6, 1302, 5.280263,
5.5, 1302, 3.400745,
6.2, 1302, 3.617906,
7.3, 1302, 3.927987,
7.8, 1302, 4.056193,
5.2, 1302, 3.303131,
4.5, 1302, 3.065407,
6.4, 1302, 3.677147,
3.384, 1302, 2.661271,
6.3, 1302, 3.647685,
4.6, 1332, 3.372855,
2.3, 1332, 2.349478,
7.2, 1332, 4.406949,
18.6, 1332, 6.596483,
8.7, 1332, 4.906634,
10.6, 1332, 5.430268,
4.6, 1332, 3.372855,
15.3, 1332, 6.275156,
6.7, 1332, 4.223599,
21.4, 1332, 6.762358,
4.2, 1332, 3.198869,
5.7, 1332, 3.833452,
16, 1332, 6.35795,
4.1, 1231, 2.96988,
2.6, 1231, 2.388537,
2.6, 1231, 2.388537,
4.6, 1231, 3.15399,
4, 1231, 2.932362,
3.4, 1231, 2.703022,
6.9, 1231, 3.910278,
3.1, 1231, 2.586029,
1.6, 1231, 1.989498,
2.2, 1231, 2.229111,
2.3, 1231, 2.269037,
3.1, 1231, 2.586029,
3.6, 1231, 2.780218,
1.9, 1231, 2.109233,
5.9, 1231, 3.601241,
1.2, 1231, 1.830748,
2.9, 1231, 2.507354,
6.1, 1231, 3.665586,
5.2, 1231, 3.366435,
7.4, 1231, 4.052721,
4.2, 1231, 3.007176,
2.9, 1231, 2.507354,
5.3, 1231, 3.400867,
13, 1231, 5.141068,
5.1, 1231, 3.331716,
7.4, 1231, 4.052721,
3.1, 1231, 2.586029,
5.2, 1231, 3.366435,
5.9, 1231, 3.601241,
8.9, 1231, 4.43182,
8.2, 1231, 4.263805,
4.4, 1231, 3.08107,
1.8, 1231, 2.069287,
4.2, 1231, 3.007176,
5.8, 1231, 3.568603,
8.3, 1261, 5.090772,
2.2, 1261, 2.34004,
7.7, 1261, 4.858741,
3.1, 1261, 2.770655,
16.5, 1261, 7.101277,
2.6, 1261, 2.530302,
7.2, 1261, 4.65632,
20.9, 1261, 7.540673,
10.6, 1320, 5.309256,
2.4, 1320, 2.380539,
15.4, 1320, 6.114619,
12.2, 1320, 5.642013,
5.7, 1320, 3.781552,
4.9, 1320, 3.460119,
14.7, 1320, 6.029965,
6, 1320, 3.897548,
2.9, 1320, 2.600872,
13.2, 1320, 5.814731,
17.9, 1320, 6.350412,
15.1, 1321, 6.07947,
2.95, 1321, 2.622891,
21.4, 1321, 6.553394,
8.3, 1321, 4.691718,
6.4, 1321, 4.048012,
5.7, 1321, 3.781552,
7.4, 1321, 4.40184,
11.4, 1321, 5.484825,
6.9, 1321, 4.229014,
5.1, 1321, 3.542024,
11.4, 1321, 5.484825,
13.3, 1321, 5.830646,
5.8, 1321, 3.820508,
2.57, 1321, 2.455432,
21, 1321, 6.535763,
13, 1321, 5.782183,
3.1, 1321, 2.688888,
6.4, 1321, 4.048012,
5, 1321, 3.501192,
12.5, 1321, 5.696496,
3.3, 1351, 2.592783,
4.7, 1351, 3.075723,
7.4, 1351, 3.851315,
11.8, 1351, 4.65713,
6.5, 1351, 3.617771,
1.58, 1351, 1.954232,
3, 1351, 2.483902,
4.6, 1351, 3.042834,
7.1, 1351, 3.776282,
1.9, 1351, 2.074727,
8.8, 1351, 4.165133,
6.3, 1351, 3.562427,
7.1, 1351, 3.776282,
6.8, 1351, 3.698437,
5.1, 1351, 3.204497,
1.78, 1351, 2.029558,
1, 1351, 1.736413,
6.2, 1351, 3.534286,
4.45, 1351, 2.992997,
1.92, 1351, 2.082251,
7.3, 1351, 3.826615,
3.4, 1351, 2.62872,
1.53, 1351, 1.935402,
1.77, 1351, 2.025792,
5.3, 1351, 3.267164,
6, 1351, 3.477072,
10, 1351, 4.389194,
3.2, 1351, 2.556662,
2.7, 1351, 2.373609,
2, 1351, 2.112333,
7.4, 1351, 3.851315,
6, 1351, 3.477072,
5.7, 1351, 3.388934,
3.2, 1351, 2.556662,
3.1, 1351, 2.520365,
4, 1351, 2.84002,
5.5, 1351, 3.328649,
3.1, 1351, 2.520365,
10.4, 1351, 4.455406,
12.2, 1351, 4.706913,
4.9, 1351, 3.140674,
5.7, 1351, 3.388934,
7.9, 1351, 3.970181,
1.12, 1351, 1.781316,
4.5, 1351, 3.009676,
11.8, 1351, 4.65713,
4, 1351, 2.84002,
3.2, 1351, 2.556662,
5.6, 1351, 3.358943,
13.2, 1351, 4.817869,
2.9, 1351, 2.447282,
4.7, 1351, 3.075723,
7.9, 1351, 3.970181,
1.7, 1351, 1.99943,
6.9, 1351, 3.724699,
2.8, 1351, 2.410514,
2.9, 1351, 2.447282,
8, 1351, 3.993036,
6.7, 1351, 3.671862,
5.7, 1351, 3.388934,
7.8, 1351, 3.947021,
5.8, 1351, 3.41862,
7.5, 1351, 3.875704,
5.6, 1351, 3.358943,
5.6, 1351, 3.358943,
1.3, 1351, 1.848866,
6.8, 1351, 3.698437,
6.8, 1351, 3.698437,
3.9, 1351, 2.805355,
5.3, 1351, 3.267164,
7, 1351, 3.750647,
5.5, 1310, 3.533054,
6.2, 1310, 3.772484,
5.8, 1310, 3.637501,
2.2, 1310, 2.247356,
5.4, 1310, 3.497646,
3.6, 1310, 2.816074,
7.2, 1310, 4.087596,
7.2, 1310, 4.087596,
5.7, 1310, 3.602986,
1.25, 1310, 1.859288,
2.64, 1310, 2.427785,
9.5, 1310, 4.688725,
9.9, 1310, 4.776278,
3.64, 1310, 2.831983,
1.16, 1310, 1.822967,
1.05, 1310, 1.778743,
2.5, 1310, 2.37045,
2.68, 1310, 2.444147,
8.5, 1310, 4.448288,
3.8, 1310, 2.895342,
6.9, 1310, 3.996478,
6.5, 1310, 3.870415,
11.7, 1310, 5.114169,
2.15, 1310, 2.226829,
1.55, 1310, 1.981105,
3.2, 1310, 2.655621,
7.8, 1310, 4.260953,
7.6, 1310, 4.204484,
9.8, 1310, 4.754838,
5.2, 1310, 3.425964,
4.6, 1310, 3.204346,
9.3, 1310, 4.643133,
1.74, 1310, 2.058711,
4, 1310, 2.97387,
1.7, 1310, 2.042351,
10.1, 1310, 4.818274,
0.85, 1310, 1.698877,
8.1, 1310, 4.343194,
7, 1310, 4.027179,
2.17, 1310, 2.23504,
5.2, 1310, 3.425964,
2.7, 1310, 2.452324,
1.89, 1310, 2.120147,
6.2, 1310, 3.772484,
4.6, 1310, 3.204346,
6.1, 1310, 3.739206,
3.9, 1310, 2.934703,
7.5, 1310, 4.175756,
2.4, 1310, 2.329443,
4.6, 1310, 3.204346,
12, 1310, 5.16225,
11.5, 1310, 5.080881,
9.7, 1310, 4.7331,
5.6, 1310, 3.568169,
1.47, 1310, 1.948523,
3.1, 1310, 2.615167,
3.4, 1310, 2.73614,
3.4, 1310, 2.73614,
3.09, 1310, 2.611115,
5.8, 1310, 3.637501,
1.57, 1310, 1.989261,
9.8, 1310, 4.754838,
2.1, 1310, 2.206303,
9.2, 1310, 4.619876,
2.81, 1310, 2.497246,
3.89, 1310, 2.930775,
3.5, 1310, 2.776186,
17, 1400, 5.701525,
14.7, 1400, 5.506908,
14.2, 1400, 5.453811,
6.4, 1400, 3.838091,
7.9, 1400, 4.288694,
8.7, 1400, 4.498899,
9.9, 1400, 4.776278,
12.5, 1400, 5.237634,
10.2, 1400, 4.838835,
5.7, 1400, 3.602986,
6.7, 1400, 3.934096,
6.1, 1400, 3.739206,
6.1, 1400, 3.739206,
16.1, 1400, 5.634191,
13, 1400, 5.307381,
11.6, 1400, 5.09765,
7.4, 1400, 4.146699,
8.1, 1400, 4.343194,
10.2, 1400, 4.838835,
16.2, 1400, 5.64219,
2.11, 1400, 2.210408,
6.5, 1400, 3.870415,
11.1, 1400, 5.011242,
8.7, 1400, 4.498899,
8.2, 1400, 4.369955,
8, 1400, 4.316108,
5.8, 1400, 3.637501,
7.5, 1400, 4.175756,
4.05, 1400, 2.993378,
6.4, 1400, 3.838091,
9.4, 1400, 4.666082,
5.2, 1400, 3.425964,
9.2, 1400, 4.619876,
1.02, 1400, 1.766717,
2.28, 1400, 2.280198,
6, 1400, 3.705614,
6.4, 1400, 3.838091,
3.3, 1400, 2.695949,
8.9, 1400, 4.548235,
10.3, 1400, 4.859109,
4.9, 1400, 3.316347,
3, 1189, 2.681519,
5.4, 1189, 3.755042,
7.7, 1189, 4.657983,
1.44, 1189, 1.97431,
5.3, 1189, 3.712342,
2.9, 1189, 2.635622,
8, 1189, 4.763234,
10.4, 1189, 5.494286,
3.9, 1189, 3.092949,
9.1, 1189, 5.122708,
9.1, 1189, 5.122708,
8, 1189, 4.763234,
2.9, 1189, 2.635622,
6.7, 1189, 4.285429,
3.3, 1189, 2.819143,
2.4, 1189, 2.406595,
2.2, 1189, 2.315463,
7.8, 1189, 4.693407,
8.2, 1189, 4.831691,
5.5, 1189, 3.797494,
4.8, 1189, 3.495378,
2.6, 1189, 2.498059,
7.5, 1189, 4.58612,
2.594, 1189, 2.495311,
5, 1189, 3.582825,
8.3, 1189, 4.865405,
5.9, 1189, 3.964697,
3.1, 1189, 2.727413,
2.989, 1189, 2.67647,
3.3, 1189, 2.819143,
3.9, 1189, 3.092949,
5.7, 1189, 3.88163,
3.3, 1189, 2.819143,
4, 1189, 3.138255,
3.6, 1189, 2.956398,
2.357, 1189, 2.38697,
1.646, 1189, 2.065754,
2.7, 1189, 2.543878,
3.5, 1189, 2.910708,
4, 1189, 3.138255,
3, 1189, 2.681519,
2.2, 1189, 2.315463,
5.8, 1189, 3.9233,
5, 1189, 3.582825,
3.2, 1189, 2.773293,
3.7, 1189, 3.002009,
4.9, 1189, 3.539206,
7.9, 1189, 4.728491,
3.1, 1189, 2.727413,
2.9, 1189, 2.635622,
3, 1189, 2.681519,
6.2, 1189, 4.087196,
8.5, 1189, 4.931799,
8.2, 1189, 4.831691,
6.1, 1189, 4.046651,
7, 1189, 4.40063,
3.6, 1189, 2.956398,
5.2, 1189, 3.6694,
6.2, 1189, 4.087196,
6.2, 1189, 4.087196,
6.8, 1189, 4.324148,
8.2, 1189, 4.831691,
7.3, 1189, 4.512916,
6.1, 1189, 4.046651,
8.9, 1189, 5.060449,
6.6, 1189, 4.246397,
8, 1219, 3.080715,
3.4, 1219, 2.271482,
5.1, 1219, 2.631433,
6.5, 1219, 2.873006,
6.4, 1219, 2.857342,
9.7, 1219, 3.261179,
8.6, 1219, 3.150521,
4, 1219, 2.406874,
3.8, 1219, 2.362738,
3.4, 1219, 2.271482,
5.2, 1219, 2.650314,
2.1, 1219, 1.949282,
4.6, 1219, 2.533197,
2.5, 1219, 2.052318,
7.9, 1219, 3.068381,
8.1, 1219, 3.092844,
2.3, 1219, 2.001199,
4.6, 1219, 2.533197,
6.3, 1219, 2.841439,
6.6, 1219, 2.888434,
5.1, 1219, 2.631433,
5, 1219, 2.612298,
2.8, 1219, 2.127409,
5.1, 1219, 2.631433,
3.4, 1219, 2.271482,
5.1, 1219, 2.631433,
4.3, 1219, 2.471183,
3.87, 1249, 2.840632,
3.89, 1249, 2.84791,
6.4, 1249, 3.677147,
7.5, 1249, 3.98022,
6.6, 1249, 3.735121,
3.63, 1249, 2.752644,
11.7, 1249, 4.804914,
8.4, 1249, 4.199685,
8.2, 1249, 4.153095,
8.8, 1249, 4.289209,
8.3, 1249, 4.176544,
2.35, 1249, 2.267211,
4.1, 1249, 2.923784,
6.2, 1249, 3.617906,
7.2, 1249, 3.901392,
5.6, 1249, 3.432688,
4.7, 1249, 3.134694,
6.6, 1249, 3.735121,
6, 1249, 3.557407,
4.53, 1249, 3.075867,
7.4, 1249, 3.954262,
11.4, 1249, 4.761439,
7.7, 1249, 4.031185,
7.8, 1249, 4.056193,
3.48, 1249, 2.697063,
14.8, 1249, 5.149229,
18.8, 1249, 5.393102,
6.3, 1249, 3.647685,
3.54, 1249, 2.719347,
1.15, 1249, 1.802244,
3.1, 1249, 2.554461,
7.2, 1279, 3.901392,
4.4, 1279, 3.030374,
10, 1279, 4.529697,
12.9, 1279, 4.959383,
1.49, 1279, 1.933623,
13.3, 1279, 5.004513,
9.8, 1279, 4.492435,
3.8, 1279, 2.815094,
8.9, 1279, 4.310839,
3.463, 1279, 2.690737,
6.4, 1279, 3.677147,
9, 1279, 4.332172,
9.1, 1279, 4.353211,
3.621, 1279, 2.749321,
5.9, 1279, 3.52669,
8, 1279, 4.105268,
9.6, 1279, 4.454071,
21.3, 1245, 7.567852,
4, 1245, 3.205083,
1.1, 1245, 1.834295,
1.2, 1245, 1.878858,
1.5, 1245, 2.014457,
2, 1245, 2.245907,
3.925, 1245, 3.168973,
7, 1245, 4.573133,
1.8, 1245, 2.152601,
2.2, 1245, 2.34004,
17.2, 1245, 7.191895,
3.7, 1245, 3.060456,
1.3, 1245, 1.923749,
3.9, 1245, 3.156928,
18.8, 1245, 7.366882,
0.9, 1245, 1.746215,
1.3, 1245, 1.923749,
0.45, 1245, 1.553674,
19.3, 1245, 7.413465,
20.7, 1245, 7.526436,
3.5, 1245, 2.963851,
2, 1245, 2.245907,
4, 1245, 3.205083,
2.2, 1245, 2.34004,
2.6, 1245, 2.530302,
2.4, 1245, 2.434878,
8.2, 1245, 5.052943,
17.3, 1245, 7.204096,
3.8, 1245, 3.108715,
5, 1275, 3.353158,
5.4, 1275, 3.497646,
2.7, 1275, 2.452324,
11.7, 1275, 5.114169,
11.4, 1275, 5.063858,
9.3, 1275, 4.643133,
11.8, 1275, 5.13044,
9.3, 1275, 4.643133,
2.5, 1275, 2.37045,
9.7, 1275, 4.7331,
5.1, 1275, 3.389699,
6.7, 1275, 3.934096,
1.7, 1275, 2.042351,
4.6, 1275, 3.204346,
10.4, 1275, 4.879097,
4.5, 1275, 3.16651,
7.3, 1275, 4.117312,
4.2, 1275, 3.051589,
8, 1275, 4.316108,
2.6, 1275, 2.411414,
3.7, 1275, 2.855796,
4, 1275, 2.97387,
7.8, 1275, 4.260953,
11.1, 1275, 5.011242,
1.6, 1275, 2.0015,
6.2, 1275, 3.772484,
3.7, 1275, 2.855796,
8.2, 1275, 4.369955,
1.6, 1275, 2.0015,
3.1, 1275, 2.615167,
22.3, 1275, 5.941205,
7.6, 1275, 4.204484,
1.2, 1275, 1.839095,
8.7, 1275, 4.498899,
1.9, 1275, 2.124246,
12.4, 1305, 5.22302,
7.2, 1305, 4.087596,
14.5, 1305, 5.48619,
7.2, 1305, 4.087596,
14.7, 1305, 5.506908,
2.7, 1305, 2.452324,
7.7, 1305, 4.232883,
6, 1305, 3.705614,
12.7, 1305, 5.26619,
5.7, 1305, 3.602986,
6.6, 1305, 3.902417,
3.7, 1305, 2.855796,
12.4, 1305, 5.22302,
2.7, 1305, 2.452324,
6.6, 1305, 3.902417,
6.1, 1305, 3.739206,
3.8, 1305, 2.895342,
4.1, 1305, 3.012835,
1.1, 1305, 1.798821,
4, 1305, 2.97387,
7.4, 1305, 4.146699,
4.4, 1305, 3.128434,
3.3, 1305, 2.695949,
5, 1305, 3.353158,
7.8, 1305, 4.260953,
1.7, 1305, 2.042351,
6.4, 1305, 3.838091,
1, 1305, 1.758708,
7.2, 1305, 4.087596,
8.4, 1305, 4.422501,
1.2, 1305, 1.839095,
7, 1305, 4.027179,
5.7, 1305, 3.602986,
2.3, 1305, 2.288408,
10.1, 1305, 4.818274,
5.9, 1305, 3.671711,
9.2, 1305, 4.619876,
5.9, 1305, 3.671711,
7.6, 1305, 4.204484,
4.8, 1305, 3.279271,
5.7, 1305, 3.602986,
4.2, 1305, 3.051589,
1.4, 1305, 1.920067,
3.9, 1305, 2.934703,
6.5, 1305, 3.870415,
6.2, 1305, 3.772484,
3.8, 1305, 2.895342,
2.5, 1305, 2.37045,
5.1, 1305, 3.389699,
3.9, 1305, 2.934703,
1.9, 1305, 2.124246,
7.9, 1305, 4.288694,
3.9, 1305, 2.934703,
4.7, 1305, 3.241935,
9.4, 1305, 4.666082,
4.6, 1305, 3.204346,
9.1, 1305, 4.596309,
8.6, 1305, 4.473754,
6.4, 1305, 3.838091,
5.6, 1305, 3.568169,
8.8, 1305, 4.523726,
8.5, 1305, 4.448288,
7.2, 1305, 4.087596,
7.2, 1305, 4.087596,
2, 1335, 2.215448,
15.5, 1335, 6.299735,
12.3, 1335, 5.802393,
7.3, 1335, 4.442632,
1.7, 1335, 2.082502,
2.4, 1335, 2.394325,
2.1, 1335, 2.260024,
4.9, 1335, 3.501294,
2.1, 1335, 2.260024,
3.3, 1335, 2.798998,
1.6, 1335, 2.0385,
8.9, 1335, 4.96745,
2.6, 1335, 2.484188,
3.4, 1335, 2.84383,
5.6, 1335, 3.792836,
8.7, 1335, 4.906634,
1.2, 1335, 1.864471,
1.7, 1335, 2.082502,
1.1, 1335, 1.821538,
2.9, 1335, 2.619188,
3.3, 1335, 2.798998,
5.3, 1335, 3.669387,
4.4, 1335, 3.286223,
4.9, 1335, 3.501294,
6.5, 1335, 4.148005,
5.8, 1335, 3.873792,
2, 1335, 2.215448,
0.8, 1335, 1.694372,
2.7, 1335, 2.529174,
2.3, 1335, 2.349478,
9.5, 1335, 5.141747,
2.1, 1335, 2.260024,
4.9, 1335, 3.501294,
6.8, 1335, 4.260918,
7.4, 1335, 4.477982,
6.7, 1335, 4.223599,
6.2, 1335, 4.032281,
13.4, 1335, 6.000362,
9.4, 1335, 5.113542,
8.3, 1335, 4.780894,
4.3, 1335, 3.242631,
7.3, 1335, 4.442632,
2.7, 1335, 2.529174,
5.2, 1335, 3.627725,
4.1, 1335, 3.154944,
6, 1335, 3.95362,
15.5, 1335, 6.299735,
2, 1335, 2.215448,
1.3, 1335, 1.90765,
3.2, 1335, 2.754105,
10.9, 1335, 5.502227,
4.8, 1335, 3.458694,
5.8, 1335, 3.873792,
3.2, 1335, 2.754105,
5.201, 1365, 3.303461,
13.7, 1365, 5.046745,
8.9, 1365, 4.310839,
6.1, 1365, 3.587813,
9, 1365, 4.332172,
5.2, 1365, 3.303131,
7.8, 1365, 4.056193,
11.6, 1365, 4.79065,
12.1, 1365, 4.859755,
8.4, 1365, 4.199685,
11.4, 1365, 4.761439,
9.2, 1365, 4.373959,
10.1, 1365, 4.547921,
2.9, 1365, 2.478504,
9.6, 1365, 4.454071,
7.6, 1365, 4.005861,
5.3, 1365, 3.335964,
6.4, 1365, 3.677147,
7.4, 1365, 3.954262,
15.1, 1365, 5.174002,
5.2, 1365, 3.303131,
6.2, 1365, 3.617906,
8.4, 1365, 4.199685,
5.7, 1365, 3.464328,
8.5, 1235, 3.139374,
0.97, 1235, 1.643331,
2.1674, 1235, 1.966865,
10.1, 1235, 3.29637,
14.2, 1235, 3.539664,
3.9, 1235, 2.384932,
6.7, 1235, 2.903626,
2.8, 1235, 2.127409,
2.7, 1235, 2.102596,
3.6, 1235, 2.317603,
3, 1235, 2.176363,
3.5, 1235, 2.294665,
3.384, 1235, 2.267751,
19.5, 1265, 7.050825,
19.6, 1265, 7.058249,
9.9, 1265, 5.46004,
6.4, 1265, 4.221038,
11.9, 1265, 5.982814,
9.5, 1265, 5.339612,
10.2, 1265, 5.546793,
12.5, 1265, 6.115388,
8.8, 1265, 5.115614,
10.7, 1265, 5.684697,
15, 1265, 6.563675,
13.3, 1265, 6.276262,
8.3, 1265, 4.945232,
5.2, 1265, 3.707693,
2.5, 1265, 2.463824,
12.5, 1265, 6.115388,
6.3, 1265, 4.179755,
9.2, 1265, 5.245687,
3.3, 1265, 2.837185,
2.5, 1265, 2.463824,
9.9, 1265, 5.46004,
7.1, 1265, 4.501515,
2.3, 1295, 2.172683,
6.1, 1295, 3.329036,
2.2, 1295, 2.138093,
2.12, 1295, 2.110337,
21.2, 1295, 4.813292,
2.278, 1295, 2.165084,
2.199, 1295, 2.137746,
1.6065, 1295, 1.930835,
1.725, 1295, 1.972424,
3.226, 1295, 2.485877,
2.12, 1295, 2.110337,
2.752, 1295, 2.327347,
2.8, 1295, 2.343586,
2.278, 1295, 2.165084,
6.9, 1295, 3.521359,
7.1, 1295, 3.566459,
11, 1295, 4.229389,
2.2, 1295, 2.138093,
18.4, 1295, 4.74207,
5.7, 1295, 3.225677,
8.5, 1325, 4.931799,
6.2, 1325, 4.087196,
6.2, 1325, 4.087196,
11.2, 1325, 5.695352,
12.2, 1325, 5.91899,
5.9, 1325, 3.964697,
4.8, 1325, 3.495378,
11.1, 1325, 5.671325,
2.8073, 1325, 2.593086,
2.0015, 1325, 2.225459,
9.1, 1325, 5.122708,
6.4, 1325, 4.167402,
5.1, 1325, 3.626226,
10.9, 1325, 5.622334,
8.2, 1325, 4.831691,
6.3, 1325, 4.127449,
8.4, 1325, 4.898774,
3.6, 1325, 2.956398,
8.1, 1325, 4.797634,
7.1, 1325, 4.438385,
2.3175, 1325, 2.368956,
9.7, 1325, 5.301273,
10.5, 1325, 5.52054,
14.7, 1325, 6.359428,
7.9, 1325, 4.728491,
13.2, 1325, 6.114166,
3.6, 1325, 2.956398,
3.5, 1325, 2.910708,
8.9, 1325, 5.060449,
6.2, 1325, 4.087196,
4.7, 1355, 2.46148,
4.2, 1355, 2.368121,
2.1, 1355, 1.910709,
5.7, 1355, 2.629992,
4.1, 1355, 2.348713,
7.5, 1355, 2.875816,
4.9, 1355, 2.497111,
3.2, 1355, 2.163093,
2.7, 1355, 2.051683,
3.4, 1355, 2.206027,
2.5, 1355, 2.005544,
3.6, 1355, 2.248007,
8, 1355, 2.932209,
2, 1355, 1.886492,
4, 1355, 2.32906,
2.8, 1355, 2.074422,
6.1, 1355, 2.690785,
2.278, 1355, 1.95332,
2.4, 1355, 1.982149,
12.5, 1355, 3.265097,
2.4, 1355, 1.982149,
3.1, 1355, 2.141273,
3.9, 1355, 2.309162,
3.4, 1355, 2.206027,
2.436, 1355, 1.990595,
4.6, 1355, 2.443299,
5.5, 1355, 2.5982,
12.5, 1355, 3.265097,
15, 1355, 3.358021,
2.6, 1355, 2.028723,
17.2, 1355, 3.409057,
8.6, 1205, 5.127749,
11.2, 1205, 5.928545,
6.6, 1205, 4.354947,
5.6, 1205, 3.922611,
5, 1205, 3.651412,
9, 1205, 5.266087,
4.8, 1205, 3.559404,
5.2, 1205, 3.742661,
15.6, 1205, 6.812027,
10.1, 1205, 5.6179,
2.5308, 1205, 2.488402,
5.5, 1205, 3.877961,
11.3, 1205, 5.954809,
5.9, 1205, 4.055103,
6.7, 1205, 4.396636,
6.1, 1205, 4.142152,
4.9, 1205, 3.605499,
12.2, 1205, 6.176982,
11.9, 1205, 6.105719,
6.5, 1205, 4.312962,
6.1, 1205, 4.142152,
6.1, 1205, 4.142152,
6.3, 1205, 4.22812,
9.3, 1205, 5.366191,
10.1, 1205, 5.6179,
4.1, 1205, 3.232484,
6.7, 1205, 4.396636,
10, 1205, 5.587641,
9.4, 1205, 5.398865,
6.8, 1205, 4.438024,
13.2, 1205, 6.395337,
7, 1205, 4.51988,
14.1, 1205, 6.568222,
15.5, 1235, 7.670233,
13.9, 1235, 7.302196,
12.9, 1235, 7.033857,
6.7, 1235, 4.632814,
17, 1235, 7.954202,
12.1, 1235, 6.79626,
9.6, 1235, 5.91438,
12.8, 1235, 7.005296,
11.9, 1235, 6.733562,
18.8, 1235, 8.228654,
3.7, 1235, 3.114726,
10.2, 1235, 6.145635,
16, 1235, 7.771031,
7.8, 1268, 4.356533,
9.3, 1268, 4.760623,
6.2, 1268, 3.843537,
3.7, 1268, 2.890264,
5.6, 1268, 3.630033,
4.4, 1268, 3.172551,
5.7, 1268, 3.666373,
9.6, 1268, 4.832721,
7.3, 1268, 4.205292,
8.2, 1268, 4.471527,
4.7, 1268, 3.290373,
3, 1268, 2.600184,
8.6, 1268, 4.58122,
7.6, 1268, 4.297036,
9.5, 1268, 4.809002,
1.646, 1268, 2.031537,
5.9, 1268, 3.738156,
5.6, 1268, 3.630033,
6, 1268, 3.773592,
7.1, 1268, 4.142467,
11.4, 1268, 5.208639,
7.1, 1268, 4.142467,
10.2, 1268, 4.968572,
6.4, 1268, 3.912225,
4, 1268, 3.012391,
4.3, 1268, 3.132824,
3.7, 1268, 2.890264,
7, 1268, 4.110558,
11.3, 1268, 5.190166,
7.2, 1268, 4.174046,
10.7, 1268, 5.073567,
5.8, 1268, 3.702415,
3.2, 1268, 2.683654,
8.9, 1268, 4.660045,
12.7, 1268, 5.425484,
7.5, 1268, 4.266788,
4.3, 1268, 3.132824,
3.1, 1268, 2.641967,
7.2, 1268, 4.174046,
7.4, 1268, 4.236207,
12.1, 1268, 5.330624,
8.7, 1268, 4.607821,
4.4, 1268, 3.172551,
8.6, 1268, 4.58122,
11.5, 1268, 5.226844,
2.436, 1295, 2.275596,
3.925, 1295, 2.814043,
12.8, 1295, 4.775696,
3.7, 1295, 2.735341,
7.9, 1295, 3.970181,
2.278, 1295, 2.216597,
3, 1295, 2.483902,
4.8, 1295, 3.108337,
4.5, 1295, 3.009676,
12.4, 1295, 4.730606,
5.5, 1295, 3.328649,
12.2, 1295, 4.706913,
4.095, 1295, 2.872732,
6, 1295, 3.477072,
5, 1295, 3.172728,
6.1, 1295, 3.505834,
4, 1295, 2.84002,
3.7, 1295, 2.735341,
8, 1295, 3.993036,
2.515, 1295, 2.305007,
21.3, 1295, 5.257949,
3.3, 1295, 2.592783,
8.7, 1295, 4.144648,
1.725, 1295, 2.008846,
5.7, 1295, 3.388934,
6.8, 1295, 3.698437,
8.3, 1295, 4.059793,
6.6, 1295, 3.644974,
5.8, 1295, 3.41862,
10.2, 1295, 4.422806,
3.6, 1295, 2.700007,
5, 1295, 3.172728,
9.1, 1295, 4.224871,
4.3, 1295, 2.942571,
4.8, 1295, 3.108337,
7.7, 1295, 3.923556,
2.989, 1295, 2.479882,
3.3, 1295, 2.592783,
6.7, 1295, 3.671862,
2.33125, 1295, 2.236506,
6.7, 1325, 3.934096,
7.4, 1325, 4.146699,
8, 1325, 4.316108,
3.779, 1325, 2.887052,
10, 1325, 4.797422,
9.3, 1325, 4.643133,
5.3, 1325, 3.461947,
2.65, 1325, 2.431876,
3.35, 1325, 2.716062,
5.4, 1325, 3.497646,
4.1, 1325, 3.012835,
4.5, 1325, 3.16651,
5.6, 1325, 3.568169,
2.3175, 1325, 2.29559,
6.4, 1325, 3.838091,
2.33125, 1325, 2.301233,
2.33125, 1325, 2.301233,
3.7, 1325, 2.855796,
5.3, 1325, 3.461947,
2.33125, 1325, 2.301233,
2.33125, 1325, 2.301233,
2.33125, 1325, 2.301233,
5.5, 1325, 3.533054,
2.8, 1325, 2.493166,
4, 1325, 2.97387,
2.357, 1325, 2.3118,
2.12, 1325, 2.214513,
2.436, 1325, 2.344209,
9.9, 1325, 4.776278,
9.4, 1325, 4.666082,
2.0015, 1325, 2.165877,
5.6, 1325, 3.568169,
3.2, 1325, 2.655621,
3.068, 1325, 2.602198,
2.8, 1325, 2.493166,
2.278, 1325, 2.279377,
2.4, 1325, 2.329443,
2.12, 1325, 2.214513,
3.4, 1325, 2.73614,
2.91, 1325, 2.538,
14.2, 1325, 5.453811,
7.3, 1325, 4.117312,
4.2, 1325, 3.051589,
6.8, 1325, 3.96545,
5.7, 1355, 2.847023,
8.8, 1355, 3.327242,
7.4, 1355, 3.138476,
5.3, 1355, 2.767643,
5.6, 1355, 2.827575,
19.3, 1355, 3.888608,
5.7, 1355, 2.847023,
6.8, 1355, 3.043855,
6.8, 1355, 3.043855,
3.4, 1355, 2.332947,
4.1, 1355, 2.50402,
8.9, 1355, 3.339134,
4.5, 1355, 2.596128,
3, 1355, 2.229815,
2.594, 1355, 2.121435,
2.6, 1355, 2.123062,
13, 1355, 3.68331,
7.2, 1355, 3.107898
]);
var buf52 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf52);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc52 = gl.getUniformLocation(prog52,"mvMatrix");
var prMatLoc52 = gl.getUniformLocation(prog52,"prMatrix");
// ****** text object 54 ******
var prog54  = gl.createProgram();
gl.attachShader(prog54, getShader( gl, "unnamed_chunk_4vshader54" ));
gl.attachShader(prog54, getShader( gl, "unnamed_chunk_4fshader54" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog54, 0, "aPos");
gl.bindAttribLocation(prog54, 1, "aCol");
gl.linkProgram(prog54);
var texts = [
"gompertz allometric model predictions (,can) for abba"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX54 = texinfo.canvasX;
var canvasY54 = texinfo.canvasY;
var ofsLoc54 = gl.getAttribLocation(prog54, "aOfs");
var texture54 = gl.createTexture();
var texLoc54 = gl.getAttribLocation(prog54, "aTexcoord");
var sampler54 = gl.getUniformLocation(prog54,"uSampler");
handleLoadedTexture(texture54, document.getElementById("unnamed_chunk_4textureCanvas"));
var v=new Float32Array([
11.375, 1435.765, 9.386732, 0, -0.5, 0.5, 0.5,
11.375, 1435.765, 9.386732, 1, -0.5, 0.5, 0.5,
11.375, 1435.765, 9.386732, 1, 1.5, 0.5, 0.5,
11.375, 1435.765, 9.386732, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<1; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
var buf54 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf54);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf54 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf54);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc54 = gl.getUniformLocation(prog54,"mvMatrix");
var prMatLoc54 = gl.getUniformLocation(prog54,"prMatrix");
var textScaleLoc54 = gl.getUniformLocation(prog54,"textScale");
// ****** text object 55 ******
var prog55  = gl.createProgram();
gl.attachShader(prog55, getShader( gl, "unnamed_chunk_4vshader55" ));
gl.attachShader(prog55, getShader( gl, "unnamed_chunk_4fshader55" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog55, 0, "aPos");
gl.bindAttribLocation(prog55, 1, "aCol");
gl.linkProgram(prog55);
var texts = [
"DBH"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX55 = texinfo.canvasX;
var canvasY55 = texinfo.canvasY;
var ofsLoc55 = gl.getAttribLocation(prog55, "aOfs");
var texture55 = gl.createTexture();
var texLoc55 = gl.getAttribLocation(prog55, "aTexcoord");
var sampler55 = gl.getUniformLocation(prog55,"uSampler");
handleLoadedTexture(texture55, document.getElementById("unnamed_chunk_4textureCanvas"));
var v=new Float32Array([
11.375, 1153.235, 0.2382571, 0, -0.5, 0.5, 0.5,
11.375, 1153.235, 0.2382571, 1, -0.5, 0.5, 0.5,
11.375, 1153.235, 0.2382571, 1, 1.5, 0.5, 0.5,
11.375, 1153.235, 0.2382571, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<1; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
var buf55 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf55);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf55 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf55);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc55 = gl.getUniformLocation(prog55,"mvMatrix");
var prMatLoc55 = gl.getUniformLocation(prog55,"prMatrix");
var textScaleLoc55 = gl.getUniformLocation(prog55,"textScale");
// ****** text object 56 ******
var prog56  = gl.createProgram();
gl.attachShader(prog56, getShader( gl, "unnamed_chunk_4vshader56" ));
gl.attachShader(prog56, getShader( gl, "unnamed_chunk_4fshader56" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog56, 0, "aPos");
gl.bindAttribLocation(prog56, 1, "aCol");
gl.linkProgram(prog56);
var texts = [
"Elevation"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX56 = texinfo.canvasX;
var canvasY56 = texinfo.canvasY;
var ofsLoc56 = gl.getAttribLocation(prog56, "aOfs");
var texture56 = gl.createTexture();
var texLoc56 = gl.getAttribLocation(prog56, "aTexcoord");
var sampler56 = gl.getUniformLocation(prog56,"uSampler");
handleLoadedTexture(texture56, document.getElementById("unnamed_chunk_4textureCanvas"));
var v=new Float32Array([
-3.253575, 1294.5, 0.2382571, 0, -0.5, 0.5, 0.5,
-3.253575, 1294.5, 0.2382571, 1, -0.5, 0.5, 0.5,
-3.253575, 1294.5, 0.2382571, 1, 1.5, 0.5, 0.5,
-3.253575, 1294.5, 0.2382571, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<1; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
var buf56 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf56);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf56 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf56);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc56 = gl.getUniformLocation(prog56,"mvMatrix");
var prMatLoc56 = gl.getUniformLocation(prog56,"prMatrix");
var textScaleLoc56 = gl.getUniformLocation(prog56,"textScale");
// ****** text object 57 ******
var prog57  = gl.createProgram();
gl.attachShader(prog57, getShader( gl, "unnamed_chunk_4vshader57" ));
gl.attachShader(prog57, getShader( gl, "unnamed_chunk_4fshader57" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog57, 0, "aPos");
gl.bindAttribLocation(prog57, 1, "aCol");
gl.linkProgram(prog57);
var texts = [
"Height"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX57 = texinfo.canvasX;
var canvasY57 = texinfo.canvasY;
var ofsLoc57 = gl.getAttribLocation(prog57, "aOfs");
var texture57 = gl.createTexture();
var texLoc57 = gl.getAttribLocation(prog57, "aTexcoord");
var sampler57 = gl.getUniformLocation(prog57,"uSampler");
handleLoadedTexture(texture57, document.getElementById("unnamed_chunk_4textureCanvas"));
var v=new Float32Array([
-3.253575, 1153.235, 4.812494, 0, -0.5, 0.5, 0.5,
-3.253575, 1153.235, 4.812494, 1, -0.5, 0.5, 0.5,
-3.253575, 1153.235, 4.812494, 1, 1.5, 0.5, 0.5,
-3.253575, 1153.235, 4.812494, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<1; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3
]);
var buf57 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf57);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf57 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf57);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc57 = gl.getUniformLocation(prog57,"mvMatrix");
var prMatLoc57 = gl.getUniformLocation(prog57,"prMatrix");
var textScaleLoc57 = gl.getUniformLocation(prog57,"textScale");
// ****** points object 58 ******
var prog58  = gl.createProgram();
gl.attachShader(prog58, getShader( gl, "unnamed_chunk_4vshader58" ));
gl.attachShader(prog58, getShader( gl, "unnamed_chunk_4fshader58" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog58, 0, "aPos");
gl.bindAttribLocation(prog58, 1, "aCol");
gl.linkProgram(prog58);
var v=new Float32Array([
6.2, 1239, 4.673717,
2.07, 1239, 2.36984,
2.55, 1239, 2.628182,
6.1, 1239, 4.619103,
1.6, 1239, 2.124677,
9.4, 1239, 6.264593,
4.7, 1239, 3.836593,
2.9, 1239, 2.820591,
6.3, 1239, 4.728105,
1.91, 1239, 2.285428,
10.7, 1239, 6.804671,
2.31, 1239, 2.498118,
4.8, 1239, 3.893257,
1.51, 1239, 2.078753,
3.3, 1239, 3.043644,
8.9, 1239, 6.03941,
2.79, 1239, 2.759806,
3.5, 1239, 3.156125,
8.2, 1239, 5.708463,
3.5, 1239, 3.156125,
2.71, 1239, 2.715772,
3.2, 1239, 2.987618,
2.1, 1239, 2.38577,
2.3, 1239, 2.492736,
0.5, 1239, 1.590454,
11.2, 1239, 6.99476,
8.3, 1239, 5.75683,
6.9, 1239, 5.04923,
10.3, 1239, 6.645547,
10, 1239, 6.522081,
6.6, 1239, 4.889832,
8.7, 1239, 5.94669,
10.4, 1239, 6.685917,
7.1, 1239, 5.154098,
12.3, 1239, 7.37899,
7.2, 1239, 5.206092,
7.3, 1239, 5.257784,
9.6, 1239, 6.351979,
9.8, 1239, 6.437811,
1.8, 1239, 2.227948,
3.9, 1239, 3.382365,
7.1, 1269, 4.855465,
2.95, 1269, 2.744669,
10, 1269, 6.108492,
4.3, 1269, 3.443305,
3.6, 1269, 3.079407,
7, 1269, 4.807671,
3.3, 1269, 2.924299,
6.23, 1269, 4.431399,
5.2, 1269, 3.909564,
18.2, 1269, 8.182583,
3.5, 1269, 3.027612,
13, 1269, 7.102987,
3.1, 1269, 2.821443,
8.2, 1269, 5.362494,
10.3, 1269, 6.221981,
13.1, 1269, 7.130919,
5.3, 1269, 3.960934,
8.7, 1269, 5.580637,
9.3, 1269, 5.831468,
2.87, 1269, 2.70387,
3.59, 1269, 3.074224,
11.5, 1269, 6.644398,
3.1, 1269, 2.821443,
4.3, 1269, 3.443305,
5.4, 1269, 4.012178,
10.6, 1269, 6.332311,
5.4, 1269, 4.012178,
7.1, 1269, 4.855465,
10.2, 1269, 6.184502,
11, 1269, 6.474506,
3.2, 1269, 2.872807,
7.5, 1269, 5.043924,
11.4, 1269, 6.611114,
8.2, 1269, 5.362494,
4.6, 1269, 3.599281,
2.79, 1269, 2.663183,
3.1, 1269, 2.821443,
8.7, 1299, 5.223635,
19.1, 1299, 7.733265,
14.8, 1299, 7.036235,
8.5, 1299, 5.145125,
10, 1299, 5.704603,
17.5, 1299, 7.51772,
16.2, 1299, 7.306222,
8.3, 1299, 5.065454,
4.6, 1299, 3.422741,
4.7, 1299, 3.469984,
5.8, 1299, 3.983243,
9.4, 1299, 5.489034,
5.2, 1299, 3.705007,
12.1, 1299, 6.371031,
8.4, 1299, 5.105433,
2.3, 1299, 2.341907,
4.6, 1329, 3.136709,
18.7, 1329, 6.749813,
13.4, 1329, 5.911179,
9.2, 1329, 4.808604,
5, 1329, 3.295431,
8.2, 1329, 4.481514,
3.91, 1329, 2.860653,
3.2, 1329, 2.575912,
4.3, 1329, 3.016936,
14.9, 1329, 6.203541,
3.67, 1329, 2.764337,
9, 1329, 4.745121,
17.2, 1329, 6.563855,
1.6, 1329, 1.9478,
1.9, 1329, 2.062925,
3.67, 1329, 2.764337,
6.6, 1329, 3.911306,
7.8, 1329, 4.344099,
5.1, 1329, 3.33489,
7.9, 1329, 4.378792,
6.3, 1329, 3.798772,
10, 1329, 5.052587,
5.6, 1329, 3.53054,
4.9, 1329, 3.255876,
4.1, 1329, 2.936848,
6.39, 1329, 3.832697,
5.8, 1329, 3.607919,
4.6, 1329, 3.136709,
7.7, 1329, 4.309183,
23, 1329, 7.120745,
2.39, 1329, 2.254087,
2, 1329, 2.101648,
5.9, 1329, 3.646396,
8.1, 1329, 4.447502,
5.2, 1329, 3.374248,
5.7, 1329, 3.569298,
3.11, 1329, 2.539917,
2.63, 1329, 2.348843,
8.3, 1360, 2.497658,
6.6, 1360, 2.305549,
4.07, 1360, 1.977699,
7, 1360, 2.352849,
4.5, 1360, 2.036746,
1.9, 1360, 1.662396,
3.99, 1360, 1.966575,
3.51, 1360, 1.89895,
4.7, 1360, 2.063769,
6.3, 1360, 2.269234,
3.75, 1360, 1.932947,
0.71, 1360, 1.480299,
6.9, 1360, 2.341145,
4.4, 1360, 2.023128,
5, 1360, 2.103763,
4.95, 1360, 2.097143,
5.7, 1360, 2.194478,
3.91, 1360, 1.955408,
3.35, 1360, 1.876085,
19.2, 1240, 11.46314,
5.1, 1240, 5.011112,
9, 1240, 7.831151,
3.9, 1240, 4.05955,
3.9, 1240, 4.05955,
2.9, 1240, 3.282494,
16.2, 1240, 10.86907,
12.2, 1240, 9.527191,
17.8, 1240, 11.22033,
5.1, 1240, 5.011112,
10.8, 1240, 8.860471,
4, 1240, 4.138578,
5, 1240, 4.93199,
15.2, 1240, 10.60191,
19.7, 1240, 11.5375,
6.5, 1240, 6.096076,
9.1, 1240, 7.893451,
12, 1240, 9.438884,
15.2, 1240, 10.60191,
3, 1240, 3.358706,
6.4, 1271, 5.242167,
4.9, 1271, 4.285626,
18.4, 1271, 9.752443,
9.1, 1271, 6.787362,
2.3, 1271, 2.621673,
6, 1271, 4.991641,
4.5, 1271, 4.025377,
13.9, 1271, 8.736885,
5.4, 1271, 4.608976,
8.8, 1271, 6.630515,
4.4, 1271, 3.960234,
19.6, 1271, 9.929397,
17.1, 1271, 9.521879,
9.7, 1271, 7.088717,
5.8, 1271, 4.864902,
7.4, 1271, 5.847241,
12.1, 1302, 5.032099,
7.9, 1302, 3.97468,
5.5, 1302, 3.218136,
11.7, 1302, 4.947198,
2.71, 1302, 2.262081,
12, 1302, 5.01118,
10.8, 1302, 4.74408,
14, 1302, 5.392037,
13.1, 1302, 5.230266,
9.3, 1302, 4.367794,
6.2, 1302, 3.448049,
4.9, 1302, 3.016428,
19.1, 1302, 6.055945,
9.6, 1302, 4.446827,
6, 1302, 3.383031,
8.7, 1302, 4.204145,
7, 1302, 3.702028,
2.31, 1302, 2.124631,
9.7, 1302, 4.472754,
4.2, 1302, 2.777118,
6.7, 1302, 3.607985,
3.11, 1332, 2.717708,
6.2, 1332, 4.16563,
20, 1332, 7.835678,
11.1, 1332, 6.070717,
13.5, 1332, 6.741326,
7.6, 1332, 4.777784,
20.2, 1332, 7.856782,
8, 1332, 4.943816,
25.1, 1332, 8.226152,
6, 1332, 4.074786,
3.7, 1332, 2.996183,
4.9, 1332, 3.56426,
4.95, 1332, 3.587778,
7.7, 1231, 5.461408,
10.4, 1231, 6.685917,
6.2, 1231, 4.673717,
6.6, 1231, 4.889832,
10.5, 1231, 6.725894,
10.1, 1231, 6.563629,
3.1, 1231, 2.931756,
3.7, 1231, 3.269073,
2.7, 1231, 2.710279,
5.6, 1231, 4.342998,
9.6, 1231, 6.351979,
6.5, 1231, 4.836171,
5.8, 1231, 4.454009,
6.2, 1231, 4.673717,
5.9, 1231, 4.50924,
6, 1231, 4.564275,
5.2, 1231, 4.119084,
3.1, 1231, 2.931756,
3.2, 1231, 2.987618,
4.1, 1231, 3.495879,
8.1, 1231, 5.659742,
3.8, 1231, 3.325684,
1.59, 1231, 2.119557,
2.63, 1231, 2.671895,
1.35, 1231, 1.997999,
2.8, 1231, 2.76532,
3.4, 1231, 3.099818,
4, 1231, 3.439102,
2.31, 1231, 2.498118,
6.6, 1231, 4.889832,
3.6, 1231, 3.212548,
6.2, 1231, 4.673717,
8.4, 1231, 5.80484,
5, 1231, 4.006361,
3.2, 1231, 2.987618,
5.7, 1231, 4.398592,
13.8, 1231, 7.831013,
5.9, 1231, 4.50924,
8.1, 1231, 5.659742,
3.6, 1231, 3.212548,
7.4, 1231, 5.309167,
10.8, 1231, 6.843471,
9.8, 1231, 6.437811,
5.1, 1231, 4.062777,
4.3, 1231, 3.609498,
6.7, 1231, 4.943234,
7.1, 1231, 5.154098,
9.2, 1261, 7.111431,
8.4, 1261, 6.666429,
32.1, 1261, 11.07382,
17.6, 1261, 10.00352,
21.5, 1261, 10.55174,
22.2, 1261, 10.61965,
3.4, 1320, 2.734712,
17.3, 1320, 6.938803,
14.5, 1320, 6.463976,
7.1, 1320, 4.28056,
5.3, 1320, 3.547288,
17.1, 1320, 6.910023,
3.7, 1320, 2.863559,
15.5, 1320, 6.652229,
22.4, 1320, 7.468544,
17.3, 1321, 8.043563,
4.5, 1321, 3.547325,
7.5, 1321, 5.043924,
8.7, 1321, 5.580637,
8.1, 1321, 5.317903,
13.9, 1321, 7.343042,
5.9, 1321, 4.266173,
9.1, 1321, 5.749211,
22.6, 1321, 8.660101,
15.1, 1321, 7.625317,
3.7, 1321, 3.131275,
7.1, 1321, 4.855465,
5.7, 1321, 4.165057,
14, 1321, 7.368173,
2.87, 1321, 2.70387,
2.8, 1351, 2.447344,
8.2, 1351, 4.588459,
13.2, 1351, 6.025937,
7.7, 1351, 4.409606,
3, 1351, 2.529716,
5.4, 1351, 3.520747,
5.3, 1351, 3.480154,
2.63, 1351, 2.377618,
10.1, 1351, 5.211368,
7.8, 1351, 4.445844,
8, 1351, 4.517624,
8.5, 1351, 4.692897,
3, 1351, 2.529716,
7.6, 1351, 4.37314,
5.8, 1351, 3.681838,
8, 1351, 4.517624,
7.3, 1351, 4.262404,
11.7, 1351, 5.662749,
2.8, 1351, 2.447344,
6.1, 1351, 3.801142,
3.7, 1351, 2.819852,
5.5, 1351, 3.561218,
5.5, 1351, 3.561218,
11.9, 1351, 5.714465,
7.1, 1351, 4.187498,
6.4, 1351, 3.918982,
9.5, 1351, 5.024711,
4.4, 1351, 3.110452,
4, 1351, 2.944514,
8, 1351, 4.517624,
14.5, 1351, 6.296637,
3.8, 1351, 2.861409,
5.1, 1351, 3.398628,
9.1, 1351, 4.895052,
2.6, 1351, 2.365345,
4, 1351, 2.944514,
8.8, 1351, 4.795111,
9.5, 1351, 5.024711,
9.6, 1351, 5.056476,
10, 1351, 5.180916,
7.7, 1351, 4.409606,
6, 1351, 3.76153,
3.9, 1351, 2.902966,
8.2, 1351, 4.588459,
9, 1351, 4.861993,
4.2, 1351, 3.027551,
6.5, 1351, 3.957912,
3.9, 1351, 2.902966,
3.4, 1351, 2.695272,
2.6, 1351, 2.365345,
9.1, 1351, 4.895052,
6.5, 1310, 4.300467,
6.5, 1310, 4.300467,
7.2, 1310, 4.607566,
4, 1310, 3.138425,
8.5, 1310, 5.145125,
8.3, 1310, 5.065454,
11.4, 1310, 6.164033,
11.6, 1310, 6.224702,
2.31, 1310, 2.346478,
11.1, 1310, 6.070717,
8.1, 1310, 4.984643,
9.1, 1310, 5.377101,
13.485, 1310, 6.737656,
2.7, 1310, 2.526216,
8.7, 1310, 5.223635,
9.1, 1310, 5.377101,
11.1, 1310, 6.070717,
6.2, 1310, 4.16563,
10.1, 1310, 5.739445,
3.9, 1310, 3.090993,
11.6, 1310, 6.224702,
10.4, 1310, 5.842103,
9, 1310, 5.339184,
2.07, 1310, 2.237364,
5.5, 1310, 3.844743,
6.4, 1310, 4.255721,
5.8, 1310, 3.983243,
7.2, 1310, 4.607566,
7, 1310, 4.520972,
1.83, 1310, 2.129596,
8.8, 1310, 5.262449,
14.4, 1310, 6.950253,
14.7, 1310, 7.015124,
6.5, 1310, 4.300467,
4.9, 1310, 3.56426,
6.9, 1310, 4.47732,
10.7, 1310, 5.94195,
2.2, 1310, 2.296311,
10.8, 1310, 5.974609,
3, 1310, 2.666124,
3.9, 1310, 3.090993,
6, 1310, 4.074786,
8.7, 1310, 5.223635,
6.6, 1310, 4.345006,
5, 1310, 3.611273,
6.9, 1310, 4.47732,
10.4, 1310, 5.842103,
7.3, 1310, 4.650499,
7.1, 1310, 4.564389,
5.6, 1310, 3.891057,
10.9, 1310, 6.006956,
4.2, 1310, 3.233293,
4.4, 1310, 3.328092,
13, 1310, 6.615592,
9.9, 1310, 5.669449,
7.8, 1310, 4.861339,
8.4, 1310, 5.105433,
19.8, 1400, 8.584782,
15.8, 1400, 7.952554,
16.8, 1400, 8.143953,
6.6, 1400, 4.705123,
10.6, 1400, 6.475605,
10.5, 1400, 6.438128,
8.2, 1400, 5.476843,
11.2, 1400, 6.692826,
15.1, 1400, 7.802976,
13.1, 1400, 7.296242,
6.4, 1400, 4.603762,
9, 1400, 5.832415,
16.1, 1400, 8.012635,
15.5, 1400, 7.89009,
12.5, 1400, 7.119218,
9.1, 1400, 5.875307,
12, 1400, 6.962278,
16.7, 1400, 8.125931,
3.7, 1400, 3.176896,
13.3, 1400, 7.352577,
11, 1400, 6.621871,
9.5, 1400, 6.043331,
7.8, 1400, 5.291078,
8.5, 1400, 5.612732,
4.6, 1400, 3.659015,
11.1, 1400, 6.65753,
10.7, 1400, 6.512718,
7.1, 1400, 4.954156,
7.4, 1400, 5.100318,
4.2, 1400, 3.444677,
12.5, 1400, 7.119218,
5.8, 1400, 4.294473,
5.7, 1189, 3.714783,
11.7, 1189, 5.809072,
9.5, 1189, 5.148444,
9.9, 1189, 5.278454,
11.1, 1189, 5.642082,
9, 1189, 4.979823,
8.2, 1189, 4.696284,
3.5, 1189, 2.777629,
9.2, 1189, 5.048079,
5.7, 1189, 3.714783,
5.1, 1189, 3.462813,
2.6, 1189, 2.393818,
9.1, 1189, 5.014084,
5.6, 1189, 3.673108,
10.1, 1189, 5.341814,
7, 1189, 4.241401,
3.2, 1189, 2.64902,
4.3, 1189, 3.12143,
7.8, 1189, 4.548427,
4.3, 1189, 3.12143,
3, 1189, 2.563586,
3.9, 1189, 2.949552,
4.6, 1189, 3.249965,
3.2, 1189, 2.64902,
7.5, 1189, 4.435002,
7, 1189, 4.241401,
4.3, 1189, 3.12143,
5.1, 1189, 3.462813,
8.1, 1189, 4.65969,
9.6, 1189, 5.181356,
3.6, 1189, 2.820582,
3.8, 1189, 2.906552,
7.4, 1189, 4.396729,
9.8, 1189, 5.246362,
9.1, 1189, 5.014084,
7.5, 1189, 4.435002,
8.3, 1189, 4.732627,
7.7, 1189, 4.510855,
7, 1189, 4.241401,
7.8, 1189, 4.548427,
10.9, 1189, 5.584231,
10, 1189, 5.310272,
7, 1189, 4.241401,
10.9, 1189, 5.584231,
8.5, 1189, 4.804552,
4.8, 1189, 3.335351,
2.3, 1189, 2.26778,
6.3, 1189, 3.961608,
5.3, 1189, 3.547288,
4.7, 1189, 3.292694,
7.7, 1189, 4.510855,
3.5, 1189, 2.777629,
4, 1189, 2.992548,
6.9, 1189, 4.202029,
4.4, 1189, 3.164325,
3.6, 1219, 2.161366,
3.6, 1219, 2.161366,
2.87, 1219, 2.002177,
6.6, 1219, 2.77488,
8.4, 1219, 3.098533,
4.1, 1219, 2.268728,
4.6, 1219, 2.374373,
9.7, 1219, 3.308126,
3.2, 1219, 2.074446,
4.2, 1219, 2.290003,
5.3, 1219, 2.518883,
2.23, 1219, 1.860996,
4.3, 1219, 2.311208,
6, 1219, 2.658873,
8.7, 1219, 3.148733,
4.3, 1219, 2.311208,
4.8, 1219, 2.416088,
2.23, 1219, 1.860996,
3.7, 1219, 2.182962,
5.3, 1219, 2.518883,
3.2, 1219, 2.074446,
4.3, 1249, 3.953569,
5.6, 1249, 4.81821,
7.1, 1249, 5.774997,
12.5, 1249, 8.443388,
8.6, 1249, 6.651603,
9.5, 1249, 7.129669,
9.6, 1249, 7.18042,
3, 1249, 3.09369,
3.4, 1249, 3.355227,
6, 1249, 5.079342,
2.6, 1249, 2.836742,
6.2, 1249, 5.208489,
2.7, 1249, 2.900474,
2.3, 1249, 2.647862,
2.31, 1249, 2.654098,
7.9, 1249, 6.254219,
6.1, 1249, 5.144044,
2.1, 1249, 2.524087,
3.51, 1249, 3.427775,
7.2, 1249, 5.836254,
5.1, 1249, 4.487613,
10.5, 1249, 7.615453,
11.9, 1249, 8.214682,
8.5, 1249, 6.596165,
15.5, 1249, 9.358883,
3.5, 1249, 3.42117,
21.4, 1249, 10.34122,
4.2, 1249, 3.886733,
4.6, 1249, 4.15415,
4.9, 1249, 4.354457,
2.07, 1279, 2.575093,
7.8, 1279, 6.551019,
9.2, 1279, 7.388402,
13.7, 1279, 9.390762,
18.7, 1279, 10.58713,
4.1, 1279, 3.987716,
3.2, 1279, 3.345803,
15.5, 1279, 9.923263,
10.8, 1279, 8.220531,
3.6, 1279, 3.629231,
10.1, 1279, 7.87328,
3, 1279, 3.205723,
11.4, 1279, 8.497478,
11.5, 1279, 8.541802,
10.7, 1279, 8.172523,
4.1, 1279, 3.987716,
7, 1279, 6.031193,
10.3, 1279, 7.975165,
11.3, 1279, 8.452634,
7.7, 1279, 6.48757,
23.3, 1245, 10.91393,
5.3, 1245, 4.773736,
2.71, 1245, 2.972114,
3.03, 1245, 3.188568,
2.55, 1245, 2.865324,
3.5, 1245, 3.512072,
2.8, 1245, 3.032625,
3.1, 1245, 3.23637,
7.6, 1245, 6.307303,
2, 1245, 2.507089,
19, 1245, 10.43631,
4.4, 1245, 4.142287,
2.63, 1245, 2.91859,
27.6, 1245, 11.15367,
20.9, 1245, 10.68738,
2.8, 1245, 3.032625,
3.2, 1245, 3.304908,
4.5, 1245, 4.212653,
2.23, 1245, 2.655092,
4.6, 1245, 4.283012,
5.8, 1245, 5.120028,
9.4, 1245, 7.358315,
18.5, 1245, 10.35705,
4.9, 1245, 4.493855,
1.67, 1245, 2.299882,
2.8, 1245, 3.032625,
3, 1245, 3.168128,
3.59, 1245, 3.574609,
2.63, 1245, 2.91859,
3.4, 1245, 3.442782,
5.2, 1275, 4.628671,
14.2, 1275, 9.187177,
14.8, 1275, 9.360863,
11.8, 1275, 8.339487,
14.1, 1275, 9.156838,
13.2, 1275, 8.86502,
5.5, 1275, 4.832277,
1.83, 1275, 2.379758,
13, 1275, 8.795425,
5.7, 1275, 4.967134,
8.5, 1275, 6.723715,
5.6, 1275, 4.899804,
12.7, 1275, 8.687676,
9.3, 1275, 7.164881,
10.1, 1275, 7.57464,
4.4, 1275, 4.081112,
4.2, 1275, 3.943945,
9.4, 1275, 7.21784,
14.7, 1275, 9.332889,
8.9, 1275, 6.94815,
11.7, 1275, 8.298429,
23.2, 1275, 10.70452,
8, 1275, 6.432703,
11.2, 1275, 8.085853,
14.7, 1305, 8.784246,
8.6, 1305, 6.396862,
16.3, 1305, 9.16807,
17.9, 1305, 9.475209,
10.2, 1305, 7.180431,
6, 1305, 4.904693,
17.8, 1305, 9.458004,
6.4, 1305, 5.148591,
8.1, 1305, 6.129227,
15.1, 1305, 8.888146,
8.5, 1305, 6.344168,
7.7, 1305, 5.907838,
4.5, 1305, 3.963956,
8.8, 1305, 6.500971,
5, 1305, 4.280548,
5.3, 1305, 4.46946,
10.2, 1305, 7.180431,
2.39, 1305, 2.649278,
8.1, 1305, 6.129227,
9.2, 1305, 6.703994,
9.1, 1305, 6.653894,
6.8, 1305, 5.388093,
11.7, 1305, 7.810603,
6.7, 1305, 5.328664,
11.4, 1305, 7.692617,
8.9, 1305, 6.552381,
6.3, 1305, 5.088003,
6.6, 1305, 5.268932,
7, 1305, 5.505998,
1.91, 1305, 2.366971,
6.6, 1305, 5.268932,
5.1, 1305, 4.343636,
9.4, 1305, 6.802865,
12.4, 1305, 8.070648,
12.2, 1305, 7.998501,
6.6, 1305, 5.268932,
12.5, 1305, 8.106086,
10.5, 1305, 7.314566,
10.2, 1305, 7.180431,
9.5, 1305, 6.851634,
9, 1305, 6.603356,
10.5, 1305, 7.314566,
8.4, 1305, 6.291054,
1.43, 1305, 2.095451,
5.5, 1335, 4.994067,
18.5, 1335, 10.55434,
10.8, 1335, 8.220531,
2.39, 1335, 2.787597,
5.2, 1335, 4.779875,
3.5, 1335, 3.558025,
7.7, 1335, 6.48757,
4.8, 1335, 4.492427,
6.5, 1335, 5.693295,
3.4, 1335, 3.487035,
1.75, 1335, 2.368312,
9.9, 1335, 7.769255,
3.1, 1335, 3.275607,
10.9, 1335, 8.268008,
3.9, 1335, 3.843923,
13.4, 1335, 9.288591,
2.47, 1335, 2.841526,
3.8, 1335, 3.772203,
1.99, 1335, 2.522831,
5.2, 1335, 4.779875,
6.3, 1335, 5.555705,
8.7, 1335, 7.100624,
7.2, 1335, 6.163686,
8.9, 1335, 7.217284,
9.2, 1335, 7.388402,
7.9, 1335, 6.614008,
2.4, 1335, 2.794321,
11.6, 1335, 8.585608,
9.1, 1335, 7.331882,
10.1, 1335, 7.87328,
7.8, 1335, 6.551019,
17.7, 1335, 10.41268,
11.1, 1335, 8.361374,
9.8, 1335, 7.716442,
4.6, 1335, 4.348243,
8.7, 1335, 7.100624,
6, 1335, 5.347028,
4.8, 1335, 4.492427,
8.2, 1335, 6.80015,
17.7, 1335, 10.41268,
3.03, 1335, 3.226654,
3.8, 1335, 3.772203,
3.9, 1335, 3.843923,
13.9, 1335, 9.456636,
8.5, 1335, 6.981929,
2.15, 1335, 2.627712,
9.9, 1335, 7.769255,
6.3, 1335, 5.555705,
2.23, 1335, 2.680678,
5.2, 1335, 4.779875,
14, 1365, 5.871953,
3.8, 1365, 2.771848,
3.1, 1365, 2.500964,
15.5, 1365, 6.136193,
13.2, 1365, 5.711966,
7.2, 1365, 4.038429,
10.3, 1365, 5.009412,
7.1, 1365, 4.003599,
10.8, 1365, 5.144805,
14.9, 1365, 6.035863,
14.2, 1365, 5.909814,
10.2, 1365, 4.981607,
13.2, 1365, 5.711966,
9.8, 1365, 4.867973,
11.8, 1365, 5.397541,
4.2, 1365, 2.926563,
11.4, 1365, 5.299317,
7.1, 1365, 4.003599,
9.2, 1365, 4.690313,
9, 1365, 4.629192,
20.2, 1365, 6.714877,
9.6, 1365, 4.80971,
8.8, 1365, 4.567133,
27.2, 1365, 7.127149,
11.7, 1365, 5.373341,
9.5, 1365, 4.780219,
5.9, 1365, 3.571588,
1.91, 1365, 2.047174,
4.2, 1365, 2.926563,
2.39, 1365, 2.228503,
2.3, 1365, 2.194286,
4.7, 1365, 3.118976,
10.9, 1235, 4.901019,
5.8, 1235, 3.389331,
3.8, 1235, 2.683165,
3.9, 1235, 2.719095,
2.47, 1235, 2.205946,
3.2, 1235, 2.467364,
15.2, 1235, 5.751142,
6.9, 1235, 3.757702,
2.23, 1235, 2.120735,
11, 1235, 4.925182,
6.5, 1235, 3.625948,
7.6, 1235, 3.981467,
8.3, 1235, 4.195817,
8, 1235, 4.105154,
6.9, 1235, 3.757702,
3.4, 1235, 2.539294,
3.1, 1235, 2.431425,
2.31, 1235, 2.149084,
2.07, 1235, 2.064224,
3.43, 1235, 2.550087,
2.15, 1235, 2.092447,
3.3, 1235, 2.503323,
5.1, 1235, 3.146194,
3.11, 1235, 2.435018,
2.07, 1235, 2.064224,
5.1, 1235, 3.146194,
5, 1235, 3.11102,
1.67, 1235, 1.924225,
8, 1235, 4.105154,
2.87, 1235, 2.348882,
3.27, 1235, 2.492533,
21.6, 1265, 11.36661,
21.5, 1265, 11.35617,
10.1, 1265, 8.17623,
13.7, 1265, 9.753762,
9.7, 1265, 7.956754,
15.1, 1265, 10.19305,
9.4, 1265, 7.786182,
13.1, 1265, 9.537943,
16.5, 1265, 10.55228,
14.1, 1265, 9.888165,
14.4, 1265, 9.984189,
11.3, 1265, 8.780121,
1.75, 1295, 2.201978,
2.23, 1295, 2.455149,
1.67, 1295, 2.160635,
3.9, 1295, 3.382365,
1.11, 1295, 1.879122,
1.99, 1295, 2.327518,
4, 1295, 3.439102,
9.1, 1295, 6.130626,
4, 1295, 3.439102,
4.2, 1295, 3.552683,
21.9, 1295, 9.194991,
1.67, 1295, 2.160635,
1.67, 1295, 2.160635,
2.47, 1295, 2.584643,
3.43, 1295, 3.116697,
3.6, 1295, 3.212548,
3.5, 1295, 3.156125,
3.2, 1295, 2.987618,
3, 1295, 2.876076,
1.43, 1295, 2.038231,
3.4, 1295, 3.099818,
2.15, 1295, 2.412387,
3.5, 1295, 3.156125,
6.5, 1295, 4.836171,
2.47, 1295, 2.584643,
4.9, 1295, 3.949851,
3.6, 1295, 3.212548,
5.2, 1295, 4.119084,
7, 1295, 5.101808,
4.5, 1295, 3.723106,
10.6, 1295, 6.765479,
2.23, 1295, 2.455149,
9.5, 1295, 6.308479,
13.4, 1295, 7.718247,
7.2, 1295, 5.206092,
3.11, 1295, 2.937335,
3.11, 1295, 2.937335,
4.7, 1295, 3.836593,
3.6, 1295, 3.212548,
1.75, 1295, 2.201978,
3.8, 1295, 3.325684,
2.47, 1295, 2.584643,
20.9, 1295, 9.098103,
2.4, 1295, 2.546695,
10, 1295, 6.522081,
3.2, 1325, 3.183917,
9.7, 1325, 7.088717,
6.6, 1325, 5.365771,
7.1, 1325, 5.669276,
12.6, 1325, 8.310001,
13.5, 1325, 8.612914,
6.6, 1325, 5.365771,
5.4, 1325, 4.608976,
12.3, 1325, 8.201364,
4.1, 1325, 3.764886,
12.4, 1325, 8.238012,
8.2, 1325, 6.304864,
13.1, 1325, 8.482469,
10.3, 1325, 7.373337,
6.9, 1325, 5.548865,
9.4, 1325, 6.940115,
3.6, 1325, 3.440678,
9.6, 1325, 7.039647,
12.5, 1325, 8.274224,
15.9, 1325, 9.267211,
11.9, 1325, 8.050346,
3.4, 1355, 2.385511,
1.99, 1355, 1.953836,
1.35, 1355, 1.760959,
1.51, 1355, 1.808849,
1.99, 1355, 1.953836,
2.6, 1355, 2.140067,
5.7, 1355, 3.075603,
2.3, 1355, 2.048278,
2.07, 1355, 1.978159,
9.9, 1355, 4.15969,
1.35, 1355, 1.760959,
1.91, 1355, 1.929554,
8.6, 1355, 3.855611,
11.4, 1355, 4.4726,
2.1, 1355, 1.987289,
3.03, 1355, 2.271983,
3.9, 1355, 2.538445,
7.2, 1355, 3.495255,
5.1, 1355, 2.899759,
5.5, 1355, 3.017426,
3.1, 1355, 2.29347,
1.83, 1355, 1.905314,
5.9, 1355, 3.133306,
4.1, 1355, 2.599334,
3.9, 1355, 2.538445,
4.3, 1355, 2.660003,
9.1, 1355, 3.976147,
2.4, 1355, 2.078839,
2.47, 1355, 2.100255,
4.4, 1355, 2.690243,
3.2, 1355, 2.324161,
2.23, 1355, 2.02691,
13.9, 1355, 4.906281,
2.31, 1355, 2.051332,
4.9, 1355, 2.840326,
1.91, 1355, 1.929554,
5.3, 1355, 2.958802,
7, 1355, 3.441171,
6.1, 1355, 3.190511,
5.3, 1355, 2.958802,
4.1, 1355, 2.599334,
7.9, 1355, 3.679532,
4.3, 1355, 2.660003,
4.3, 1355, 2.660003,
8.8, 1355, 3.904356,
2.4, 1355, 2.078839,
2.8, 1355, 2.201394,
15.2, 1355, 5.091736,
15.9, 1355, 5.181306,
5.4, 1355, 2.988168,
2.71, 1355, 2.173788,
17.6, 1355, 5.371654,
9.8, 1205, 10.03968,
6.9, 1205, 7.652798,
9.5, 1205, 9.823986,
5.8, 1205, 6.596868,
16.9, 1205, 13.22503,
11.1, 1205, 10.88831,
6.1, 1205, 6.890777,
14.5, 1205, 12.50374,
7.6, 1205, 8.287462,
6.2, 1205, 6.987864,
3.19, 1205, 3.986416,
6.5, 1205, 7.276147,
5.2, 1205, 5.99947,
13.5, 1205, 12.11045,
6.4, 1205, 7.180571,
7, 1205, 7.745453,
10.1, 1205, 10.24788,
12.7, 1205, 11.74934,
7, 1205, 7.745453,
11, 1205, 10.82792,
15.3, 1205, 12.77637,
9.3, 1205, 9.676027,
16.3, 1205, 13.07066,
16.8, 1235, 11.9986,
14.7, 1235, 11.40718,
13.5, 1235, 10.9735,
9, 1235, 8.550343,
18.6, 1235, 12.3691,
13.2, 1235, 10.85263,
11.5, 1235, 10.06365,
2.23, 1235, 2.91764,
20.6, 1235, 12.66951,
14, 1235, 11.16361,
12.2, 1235, 10.41073,
21.4, 1235, 12.76387,
4, 1235, 4.427284,
11.4, 1235, 10.01142,
18, 1235, 12.25754,
2.31, 1235, 2.982133,
9, 1268, 8.697333,
10.8, 1268, 9.851473,
7.4, 1268, 7.480123,
6.3, 1268, 6.553397,
10.5, 1268, 9.675347,
7.7, 1268, 7.721116,
8.5, 1268, 8.335503,
11.6, 1268, 10.29007,
11.8, 1268, 10.3928,
6.4, 1268, 6.640127,
7.9, 1268, 7.878655,
13.1, 1268, 10.99652,
11.3, 1268, 10.13083,
7.7, 1268, 7.721116,
14.5, 1268, 11.53241,
7.9, 1268, 7.878655,
11.6, 1268, 10.29007,
6, 1268, 6.290714,
11.5, 1268, 10.23768,
16.2, 1268, 12.04678,
3.2, 1268, 3.771343,
8, 1268, 7.95646,
8.3, 1268, 8.185909,
14.4, 1268, 11.49773,
10.9, 1268, 9.908755,
4.8, 1268, 5.213044,
9.2, 1268, 8.837112,
13.4, 1268, 11.12082,
4.5, 1295, 4.735208,
15.6, 1295, 11.29423,
10, 1295, 8.892588,
2.7, 1295, 3.233638,
3.3, 1295, 3.723084,
6, 1295, 5.999131,
15.2, 1295, 11.17832,
3, 1295, 3.47628,
14.1, 1295, 10.82123,
9.2, 1295, 8.39139,
6.2, 1295, 6.16352,
7, 1295, 6.804914,
3.3, 1295, 3.723084,
10.5, 1295, 9.18429,
6.3, 1295, 6.245166,
1.59, 1295, 2.385979,
8.8, 1295, 8.125023,
6, 1295, 5.999131,
12.8, 1295, 10.31877,
9.9, 1295, 8.832257,
5.2, 1295, 5.329796,
9.4, 1295, 8.520655,
4, 1295, 4.31041,
7.2, 1295, 6.96061,
8.1, 1325, 3.931641,
8.3, 1325, 3.986957,
8.8, 1325, 4.121923,
10.4, 1325, 4.5208,
10.2, 1325, 4.473736,
5.6, 1325, 3.182704,
4.1, 1325, 2.694712,
6.6, 1325, 3.49406,
4.7, 1325, 2.892192,
5.5, 1325, 3.150849,
7.2, 1325, 3.673708,
8.1, 1325, 3.931641,
6.8, 1325, 3.554587,
2.1, 1325, 2.03106,
5.9, 1325, 3.277535,
3.5, 1325, 2.49548,
5.2, 1325, 3.054604,
1.9, 1325, 1.965539,
5.3, 1325, 3.086795,
2.55, 1325, 2.179554,
2.63, 1325, 2.206072,
12.5, 1325, 4.966985,
13.3, 1325, 5.114588,
2.4, 1325, 2.129918,
6.9, 1325, 3.584612,
4.4, 1325, 2.793744,
3.4, 1325, 2.46219,
3.5, 1325, 2.49548,
2.7, 1325, 2.229298,
6.3, 1325, 3.402125,
2.87, 1325, 2.285775,
16.8, 1325, 5.630947,
10.5, 1325, 4.544031,
7.8, 1325, 3.847276,
8.7, 1325, 4.095315,
4.6, 1355, 2.642431,
9.3, 1355, 3.797468,
2.07, 1355, 1.934972,
10.3, 1355, 4.000468,
10.3, 1355, 4.000468,
7.9, 1355, 3.486152,
7.9, 1355, 3.486152,
6.9, 1355, 3.245336,
8.2, 1355, 3.555468,
8.8, 1355, 3.689868,
4.9, 1355, 2.724239,
6.7, 1355, 3.195454,
11.1, 1355, 4.151121,
7.9, 1355, 3.486152,
5.9, 1355, 2.990663,
2.8, 1355, 2.14033,
15, 1355, 4.743497,
9.1, 1355, 3.754913,
6, 1355, 3.0167
]);
var buf58 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf58);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc58 = gl.getUniformLocation(prog58,"mvMatrix");
var prMatLoc58 = gl.getUniformLocation(prog58,"prMatrix");
// ****** linestrip object 61 ******
var prog61  = gl.createProgram();
gl.attachShader(prog61, getShader( gl, "unnamed_chunk_4vshader61" ));
gl.attachShader(prog61, getShader( gl, "unnamed_chunk_4fshader61" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog61, 0, "aPos");
gl.bindAttribLocation(prog61, 1, "aCol");
gl.linkProgram(prog61);
var v=new Float32Array([
0, 1189, 1.37,
0.455102, 1189, 1.553003,
0.9102041, 1189, 1.743949,
1.365306, 1189, 1.941387,
1.820408, 1189, 2.143836,
2.27551, 1189, 2.349823,
2.730612, 1189, 2.557913,
3.185714, 1189, 2.76674,
3.640816, 1189, 2.975025,
4.095918, 1189, 3.181596,
4.551021, 1189, 3.385396,
5.006123, 1189, 3.585489,
5.461225, 1189, 3.781063,
5.916327, 1189, 3.97143,
6.371428, 1189, 4.156017,
6.82653, 1189, 4.334367,
7.281632, 1189, 4.506126,
7.736735, 1189, 4.671035,
8.191836, 1189, 4.828924,
8.646938, 1189, 4.979699,
9.102041, 1189, 5.123336,
9.557143, 1189, 5.259869,
10.01225, 1189, 5.389381,
10.46735, 1189, 5.512003,
10.92245, 1189, 5.627895,
11.37755, 1189, 5.73725,
11.83265, 1189, 5.840281,
12.28776, 1189, 5.937219,
12.74286, 1189, 6.028306,
13.19796, 1189, 6.113795,
13.65306, 1189, 6.193941,
14.10816, 1189, 6.269001,
14.56326, 1189, 6.339233,
15.01837, 1189, 6.404889,
15.47347, 1189, 6.466218,
15.92857, 1189, 6.523463,
16.38367, 1189, 6.576859,
16.83878, 1189, 6.626633,
17.29388, 1189, 6.673004,
17.74898, 1189, 6.716179,
18.20408, 1189, 6.756361,
18.65918, 1189, 6.793738,
19.11429, 1189, 6.828491,
19.56939, 1189, 6.860792,
20.02449, 1189, 6.890802,
20.47959, 1189, 6.918675,
20.93469, 1189, 6.944555,
21.3898, 1189, 6.968577,
21.8449, 1189, 6.990869,
22.3, 1189, 7.011549
]);
var buf61 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf61);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc61 = gl.getUniformLocation(prog61,"mvMatrix");
var prMatLoc61 = gl.getUniformLocation(prog61,"prMatrix");
// ****** linestrip object 62 ******
var prog62  = gl.createProgram();
gl.attachShader(prog62, getShader( gl, "unnamed_chunk_4vshader62" ));
gl.attachShader(prog62, getShader( gl, "unnamed_chunk_4fshader62" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog62, 0, "aPos");
gl.bindAttribLocation(prog62, 1, "aCol");
gl.linkProgram(prog62);
var v=new Float32Array([
0, 1205, 1.37,
0.455102, 1205, 1.555078,
0.9102041, 1205, 1.748871,
1.365306, 1205, 1.949986,
1.820408, 1205, 2.156981,
2.27551, 1205, 2.368404,
2.730612, 1205, 2.58282,
3.185714, 1205, 2.798844,
3.640816, 1205, 3.015164,
4.095918, 1205, 3.23056,
4.551021, 1205, 3.443912,
5.006123, 1205, 3.654217,
5.461225, 1205, 3.860586,
5.916327, 1205, 4.062249,
6.371428, 1205, 4.258552,
6.82653, 1205, 4.448954,
7.281632, 1205, 4.633018,
7.736735, 1205, 4.810409,
8.191836, 1205, 4.980881,
8.646938, 1205, 5.14427,
9.102041, 1205, 5.300487,
9.557143, 1205, 5.449508,
10.01225, 1205, 5.591364,
10.46735, 1205, 5.726138,
10.92245, 1205, 5.853949,
11.37755, 1205, 5.974956,
11.83265, 1205, 6.089342,
12.28776, 1205, 6.197313,
12.74286, 1205, 6.299094,
13.19796, 1205, 6.39492,
13.65306, 1205, 6.485037,
14.10816, 1205, 6.569694,
14.56326, 1205, 6.649143,
15.01837, 1205, 6.723638,
15.47347, 1205, 6.793427,
15.92857, 1205, 6.858757,
16.38367, 1205, 6.919868,
16.83878, 1205, 6.976994,
17.29388, 1205, 7.030362,
17.74898, 1205, 7.080189,
18.20408, 1205, 7.126687,
18.65918, 1205, 7.170055,
19.11429, 1205, 7.210485,
19.56939, 1205, 7.248162,
20.02449, 1205, 7.283257,
20.47959, 1205, 7.315937,
20.93469, 1205, 7.346356,
21.3898, 1205, 7.374663,
21.8449, 1205, 7.400996,
22.3, 1205, 7.425487
]);
var buf62 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf62);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc62 = gl.getUniformLocation(prog62,"mvMatrix");
var prMatLoc62 = gl.getUniformLocation(prog62,"prMatrix");
// ****** linestrip object 63 ******
var prog63  = gl.createProgram();
gl.attachShader(prog63, getShader( gl, "unnamed_chunk_4vshader63" ));
gl.attachShader(prog63, getShader( gl, "unnamed_chunk_4fshader63" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog63, 0, "aPos");
gl.bindAttribLocation(prog63, 1, "aCol");
gl.linkProgram(prog63);
var v=new Float32Array([
0, 1219, 1.37,
0.455102, 1219, 1.498854,
0.9102041, 1219, 1.626667,
1.365306, 1219, 1.752476,
1.820408, 1219, 1.875448,
2.27551, 1219, 1.994884,
2.730612, 1219, 2.110215,
3.185714, 1219, 2.220996,
3.640816, 1219, 2.326894,
4.095918, 1219, 2.427684,
4.551021, 1219, 2.52323,
5.006123, 1219, 2.613477,
5.461225, 1219, 2.698437,
5.916327, 1219, 2.778181,
6.371428, 1219, 2.852823,
6.82653, 1219, 2.922516,
7.281632, 1219, 2.987441,
7.736735, 1219, 3.0478,
8.191836, 1219, 3.103807,
8.646938, 1219, 3.155688,
9.102041, 1219, 3.203671,
9.557143, 1219, 3.247988,
10.01225, 1219, 3.288865,
10.46735, 1219, 3.326524,
10.92245, 1219, 3.361182,
11.37755, 1219, 3.393047,
11.83265, 1219, 3.422318,
12.28776, 1219, 3.449185,
12.74286, 1219, 3.473827,
13.19796, 1219, 3.496413,
13.65306, 1219, 3.517101,
14.10816, 1219, 3.536042,
14.56326, 1219, 3.553373,
15.01837, 1219, 3.569224,
15.47347, 1219, 3.583716,
15.92857, 1219, 3.59696,
16.38367, 1219, 3.609059,
16.83878, 1219, 3.620109,
17.29388, 1219, 3.630198,
17.74898, 1219, 3.639407,
18.20408, 1219, 3.647811,
18.65918, 1219, 3.655478,
19.11429, 1219, 3.662472,
19.56939, 1219, 3.66885,
20.02449, 1219, 3.674667,
20.47959, 1219, 3.67997,
20.93469, 1219, 3.684804,
21.3898, 1219, 3.68921,
21.8449, 1219, 3.693226,
22.3, 1219, 3.696886
]);
var buf63 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf63);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc63 = gl.getUniformLocation(prog63,"mvMatrix");
var prMatLoc63 = gl.getUniformLocation(prog63,"prMatrix");
// ****** linestrip object 64 ******
var prog64  = gl.createProgram();
gl.attachShader(prog64, getShader( gl, "unnamed_chunk_4vshader64" ));
gl.attachShader(prog64, getShader( gl, "unnamed_chunk_4fshader64" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog64, 0, "aPos");
gl.bindAttribLocation(prog64, 1, "aCol");
gl.linkProgram(prog64);
var v=new Float32Array([
0, 1231, 1.37,
0.455102, 1231, 1.540979,
0.9102041, 1231, 1.716873,
1.365306, 1231, 1.896179,
1.820408, 1231, 2.077437,
2.27551, 1231, 2.259263,
2.730612, 1231, 2.440369,
3.185714, 1231, 2.61959,
3.640816, 1231, 2.795886,
4.095918, 1231, 2.968353,
4.551021, 1231, 3.136225,
5.006123, 1231, 3.298866,
5.461225, 1231, 3.455768,
5.916327, 1231, 3.60654,
6.371428, 1231, 3.750901,
6.82653, 1231, 3.888664,
7.281632, 1231, 4.019732,
7.736735, 1231, 4.144083,
8.191836, 1231, 4.261755,
8.646938, 1231, 4.372845,
9.102041, 1231, 4.477494,
9.557143, 1231, 4.575878,
10.01225, 1231, 4.668202,
10.46735, 1231, 4.754694,
10.92245, 1231, 4.835597,
11.37755, 1231, 4.911163,
11.83265, 1231, 4.981653,
12.28776, 1231, 5.047328,
12.74286, 1231, 5.108449,
13.19796, 1231, 5.165275,
13.65306, 1231, 5.218058,
14.10816, 1231, 5.267043,
14.56326, 1231, 5.312468,
15.01837, 1231, 5.35456,
15.47347, 1231, 5.393539,
15.92857, 1231, 5.429613,
16.38367, 1231, 5.462979,
16.83878, 1231, 5.493825,
17.29388, 1231, 5.522327,
17.74898, 1231, 5.548652,
18.20408, 1231, 5.572957,
18.65918, 1231, 5.595388,
19.11429, 1231, 5.616082,
19.56939, 1231, 5.635169,
20.02449, 1231, 5.652768,
20.47959, 1231, 5.66899,
20.93469, 1231, 5.68394,
21.3898, 1231, 5.697715,
21.8449, 1231, 5.710404,
22.3, 1231, 5.722091
]);
var buf64 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf64);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc64 = gl.getUniformLocation(prog64,"mvMatrix");
var prMatLoc64 = gl.getUniformLocation(prog64,"prMatrix");
// ****** linestrip object 65 ******
var prog65  = gl.createProgram();
gl.attachShader(prog65, getShader( gl, "unnamed_chunk_4vshader65" ));
gl.attachShader(prog65, getShader( gl, "unnamed_chunk_4fshader65" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog65, 0, "aPos");
gl.bindAttribLocation(prog65, 1, "aCol");
gl.linkProgram(prog65);
var v=new Float32Array([
0, 1235, 1.37,
0.455102, 1235, 1.498854,
0.9102041, 1235, 1.626667,
1.365306, 1235, 1.752476,
1.820408, 1235, 1.875448,
2.27551, 1235, 1.994884,
2.730612, 1235, 2.110215,
3.185714, 1235, 2.220996,
3.640816, 1235, 2.326894,
4.095918, 1235, 2.427684,
4.551021, 1235, 2.52323,
5.006123, 1235, 2.613477,
5.461225, 1235, 2.698437,
5.916327, 1235, 2.778181,
6.371428, 1235, 2.852823,
6.82653, 1235, 2.922516,
7.281632, 1235, 2.987441,
7.736735, 1235, 3.0478,
8.191836, 1235, 3.103807,
8.646938, 1235, 3.155688,
9.102041, 1235, 3.203671,
9.557143, 1235, 3.247988,
10.01225, 1235, 3.288865,
10.46735, 1235, 3.326524,
10.92245, 1235, 3.361182,
11.37755, 1235, 3.393047,
11.83265, 1235, 3.422318,
12.28776, 1235, 3.449185,
12.74286, 1235, 3.473827,
13.19796, 1235, 3.496413,
13.65306, 1235, 3.517101,
14.10816, 1235, 3.536042,
14.56326, 1235, 3.553373,
15.01837, 1235, 3.569224,
15.47347, 1235, 3.583716,
15.92857, 1235, 3.59696,
16.38367, 1235, 3.609059,
16.83878, 1235, 3.620109,
17.29388, 1235, 3.630198,
17.74898, 1235, 3.639407,
18.20408, 1235, 3.647811,
18.65918, 1235, 3.655478,
19.11429, 1235, 3.662472,
19.56939, 1235, 3.66885,
20.02449, 1235, 3.674667,
20.47959, 1235, 3.67997,
20.93469, 1235, 3.684804,
21.3898, 1235, 3.68921,
21.8449, 1235, 3.693226,
22.3, 1235, 3.696886
]);
var buf65 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf65);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc65 = gl.getUniformLocation(prog65,"mvMatrix");
var prMatLoc65 = gl.getUniformLocation(prog65,"prMatrix");
// ****** linestrip object 66 ******
var prog66  = gl.createProgram();
gl.attachShader(prog66, getShader( gl, "unnamed_chunk_4vshader66" ));
gl.attachShader(prog66, getShader( gl, "unnamed_chunk_4fshader66" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog66, 0, "aPos");
gl.bindAttribLocation(prog66, 1, "aCol");
gl.linkProgram(prog66);
var v=new Float32Array([
0, 1235, 1.37,
0.455102, 1235, 1.556777,
0.9102041, 1235, 1.753874,
1.365306, 1235, 1.960141,
1.820408, 1235, 2.17434,
2.27551, 1235, 2.395177,
2.730612, 1235, 2.62133,
3.185714, 1235, 2.851475,
3.640816, 1235, 3.084314,
4.095918, 1235, 3.318596,
4.551021, 1235, 3.55313,
5.006123, 1235, 3.786803,
5.461225, 1235, 4.018586,
5.916327, 1235, 4.247547,
6.371428, 1235, 4.472848,
6.82653, 1235, 4.69375,
7.281632, 1235, 4.909615,
7.736735, 1235, 5.119896,
8.191836, 1235, 5.324142,
8.646938, 1235, 5.521983,
9.102041, 1235, 5.713136,
9.557143, 1235, 5.897389,
10.01225, 1235, 6.074599,
10.46735, 1235, 6.244683,
10.92245, 1235, 6.407615,
11.37755, 1235, 6.563416,
11.83265, 1235, 6.712147,
12.28776, 1235, 6.853909,
12.74286, 1235, 6.988831,
13.19796, 1235, 7.117069,
13.65306, 1235, 7.2388,
14.10816, 1235, 7.354218,
14.56326, 1235, 7.463529,
15.01837, 1235, 7.56695,
15.47347, 1235, 7.664705,
15.92857, 1235, 7.757021,
16.38367, 1235, 7.844129,
16.83878, 1235, 7.926258,
17.29388, 1235, 8.003636,
17.74898, 1235, 8.07649,
18.20408, 1235, 8.145041,
18.65918, 1235, 8.209503,
19.11429, 1235, 8.270089,
19.56939, 1235, 8.327003,
20.02449, 1235, 8.380439,
20.47959, 1235, 8.430591,
20.93469, 1235, 8.477638,
21.3898, 1235, 8.521757,
21.8449, 1235, 8.563115,
22.3, 1235, 8.601871
]);
var buf66 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf66);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc66 = gl.getUniformLocation(prog66,"mvMatrix");
var prMatLoc66 = gl.getUniformLocation(prog66,"prMatrix");
// ****** linestrip object 67 ******
var prog67  = gl.createProgram();
gl.attachShader(prog67, getShader( gl, "unnamed_chunk_4vshader67" ));
gl.attachShader(prog67, getShader( gl, "unnamed_chunk_4fshader67" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog67, 0, "aPos");
gl.bindAttribLocation(prog67, 1, "aCol");
gl.linkProgram(prog67);
var v=new Float32Array([
0, 1239, 1.37,
0.455102, 1239, 1.54607,
0.9102041, 1239, 1.72818,
1.365306, 1239, 1.914818,
1.820408, 1239, 2.10449,
2.27551, 1239, 2.295754,
2.730612, 1239, 2.487245,
3.185714, 1239, 2.677705,
3.640816, 1239, 2.865992,
4.095918, 1239, 3.051093,
4.551021, 1239, 3.232125,
5.006123, 1239, 3.40834,
5.461225, 1239, 3.579118,
5.916327, 1239, 3.743963,
6.371428, 1239, 3.90249,
6.82653, 1239, 4.054423,
7.281632, 1239, 4.199578,
7.736735, 1239, 4.337856,
8.191836, 1239, 4.469234,
8.646938, 1239, 4.593747,
9.102041, 1239, 4.711488,
9.557143, 1239, 4.822594,
10.01225, 1239, 4.927237,
10.46735, 1239, 5.02562,
10.92245, 1239, 5.117965,
11.37755, 1239, 5.204515,
11.83265, 1239, 5.28552,
12.28776, 1239, 5.361239,
12.74286, 1239, 5.431935,
13.19796, 1239, 5.497869,
13.65306, 1239, 5.559301,
14.10816, 1239, 5.616486,
14.56326, 1239, 5.669673,
15.01837, 1239, 5.719103,
15.47347, 1239, 5.765008,
15.92857, 1239, 5.807612,
16.38367, 1239, 5.847128,
16.83878, 1239, 5.88376,
17.29388, 1239, 5.9177,
17.74898, 1239, 5.949132,
18.20408, 1239, 5.978228,
18.65918, 1239, 6.00515,
19.11429, 1239, 6.030053,
19.56939, 1239, 6.05308,
20.02449, 1239, 6.074364,
20.47959, 1239, 6.094033,
20.93469, 1239, 6.112205,
21.3898, 1239, 6.128988,
21.8449, 1239, 6.144486,
22.3, 1239, 6.158794
]);
var buf67 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf67);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc67 = gl.getUniformLocation(prog67,"mvMatrix");
var prMatLoc67 = gl.getUniformLocation(prog67,"prMatrix");
// ****** linestrip object 68 ******
var prog68  = gl.createProgram();
gl.attachShader(prog68, getShader( gl, "unnamed_chunk_4vshader68" ));
gl.attachShader(prog68, getShader( gl, "unnamed_chunk_4fshader68" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog68, 0, "aPos");
gl.bindAttribLocation(prog68, 1, "aCol");
gl.linkProgram(prog68);
var v=new Float32Array([
0, 1240, 1.37,
0.455102, 1240, 1.55581,
0.9102041, 1240, 1.750674,
1.365306, 1240, 1.953236,
1.820408, 1240, 2.162081,
2.27551, 1240, 2.37577,
2.730612, 1240, 2.592879,
3.185714, 1240, 2.812022,
3.640816, 1240, 3.031878,
4.095918, 1240, 3.251208,
4.551021, 1240, 3.468872,
5.006123, 1240, 3.683835,
5.461225, 1240, 3.895178,
5.916327, 1240, 4.102094,
6.371428, 1240, 4.303891,
6.82653, 1240, 4.49999,
7.281632, 1240, 4.689915,
7.736735, 1240, 4.873293,
8.191836, 1240, 5.04984,
8.646938, 1240, 5.219358,
9.102041, 1240, 5.381725,
9.557143, 1240, 5.536886,
10.01225, 1240, 5.684844,
10.46735, 1240, 5.825656,
10.92245, 1240, 5.959421,
11.37755, 1240, 6.086275,
11.83265, 1240, 6.206387,
12.28776, 1240, 6.319946,
12.74286, 1240, 6.427167,
13.19796, 1240, 6.528274,
13.65306, 1240, 6.623504,
14.10816, 1240, 6.713102,
14.56326, 1240, 6.797317,
15.01837, 1240, 6.876396,
15.47347, 1240, 6.950591,
15.92857, 1240, 7.020144,
16.38367, 1240, 7.0853,
16.83878, 1240, 7.146294,
17.29388, 1240, 7.203354,
17.74898, 1240, 7.256702,
18.20408, 1240, 7.306553,
18.65918, 1240, 7.353112,
19.11429, 1240, 7.396575,
19.56939, 1240, 7.437131,
20.02449, 1240, 7.474958,
20.47959, 1240, 7.510226,
20.93469, 1240, 7.543097,
21.3898, 1240, 7.573725,
21.8449, 1240, 7.602252,
22.3, 1240, 7.628817
]);
var buf68 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf68);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc68 = gl.getUniformLocation(prog68,"mvMatrix");
var prMatLoc68 = gl.getUniformLocation(prog68,"prMatrix");
// ****** linestrip object 69 ******
var prog69  = gl.createProgram();
gl.attachShader(prog69, getShader( gl, "unnamed_chunk_4vshader69" ));
gl.attachShader(prog69, getShader( gl, "unnamed_chunk_4fshader69" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog69, 0, "aPos");
gl.bindAttribLocation(prog69, 1, "aCol");
gl.linkProgram(prog69);
var v=new Float32Array([
0, 1245, 1.37,
0.455102, 1245, 1.55581,
0.9102041, 1245, 1.750674,
1.365306, 1245, 1.953236,
1.820408, 1245, 2.162081,
2.27551, 1245, 2.37577,
2.730612, 1245, 2.592879,
3.185714, 1245, 2.812022,
3.640816, 1245, 3.031878,
4.095918, 1245, 3.251208,
4.551021, 1245, 3.468872,
5.006123, 1245, 3.683835,
5.461225, 1245, 3.895178,
5.916327, 1245, 4.102094,
6.371428, 1245, 4.303891,
6.82653, 1245, 4.49999,
7.281632, 1245, 4.689915,
7.736735, 1245, 4.873293,
8.191836, 1245, 5.04984,
8.646938, 1245, 5.219358,
9.102041, 1245, 5.381725,
9.557143, 1245, 5.536886,
10.01225, 1245, 5.684844,
10.46735, 1245, 5.825656,
10.92245, 1245, 5.959421,
11.37755, 1245, 6.086275,
11.83265, 1245, 6.206387,
12.28776, 1245, 6.319946,
12.74286, 1245, 6.427167,
13.19796, 1245, 6.528274,
13.65306, 1245, 6.623504,
14.10816, 1245, 6.713102,
14.56326, 1245, 6.797317,
15.01837, 1245, 6.876396,
15.47347, 1245, 6.950591,
15.92857, 1245, 7.020144,
16.38367, 1245, 7.0853,
16.83878, 1245, 7.146294,
17.29388, 1245, 7.203354,
17.74898, 1245, 7.256702,
18.20408, 1245, 7.306553,
18.65918, 1245, 7.353112,
19.11429, 1245, 7.396575,
19.56939, 1245, 7.437131,
20.02449, 1245, 7.474958,
20.47959, 1245, 7.510226,
20.93469, 1245, 7.543097,
21.3898, 1245, 7.573725,
21.8449, 1245, 7.602252,
22.3, 1245, 7.628817
]);
var buf69 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf69);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc69 = gl.getUniformLocation(prog69,"mvMatrix");
var prMatLoc69 = gl.getUniformLocation(prog69,"prMatrix");
// ****** linestrip object 70 ******
var prog70  = gl.createProgram();
gl.attachShader(prog70, getShader( gl, "unnamed_chunk_4vshader70" ));
gl.attachShader(prog70, getShader( gl, "unnamed_chunk_4fshader70" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog70, 0, "aPos");
gl.bindAttribLocation(prog70, 1, "aCol");
gl.linkProgram(prog70);
var v=new Float32Array([
0, 1249, 1.37,
0.455102, 1249, 1.537964,
0.9102041, 1249, 1.710241,
1.365306, 1249, 1.885344,
1.820408, 1249, 2.061843,
2.27551, 1249, 2.238395,
2.730612, 1249, 2.413763,
3.185714, 1249, 2.586836,
3.640816, 1249, 2.756634,
4.095918, 1249, 2.922318,
4.551021, 1249, 3.083182,
5.006123, 1249, 3.238652,
5.461225, 1249, 3.388279,
5.916327, 1249, 3.531726,
6.371428, 1249, 3.668762,
6.82653, 1249, 3.799248,
7.281632, 1249, 3.923126,
7.736735, 1249, 4.040408,
8.191836, 1249, 4.151167,
8.646938, 1249, 4.255523,
9.102041, 1249, 4.353638,
9.557143, 1249, 4.445705,
10.01225, 1249, 4.531943,
10.46735, 1249, 4.612588,
10.92245, 1249, 4.687889,
11.37755, 1249, 4.758102,
11.83265, 1249, 4.823489,
12.28776, 1249, 4.88431,
12.74286, 1249, 4.940824,
13.19796, 1249, 4.993282,
13.65306, 1249, 5.041934,
14.10816, 1249, 5.087017,
14.56326, 1249, 5.128761,
15.01837, 1249, 5.167387,
15.47347, 1249, 5.203104,
15.92857, 1249, 5.236113,
16.38367, 1249, 5.266602,
16.83878, 1249, 5.294749,
17.29388, 1249, 5.320723,
17.74898, 1249, 5.344681,
18.20408, 1249, 5.366771,
18.65918, 1249, 5.387132,
19.11429, 1249, 5.405892,
19.56939, 1249, 5.423174,
20.02449, 1249, 5.439088,
20.47959, 1249, 5.45374,
20.93469, 1249, 5.467226,
21.3898, 1249, 5.479636,
21.8449, 1249, 5.491054,
22.3, 1249, 5.501558
]);
var buf70 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf70);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc70 = gl.getUniformLocation(prog70,"mvMatrix");
var prMatLoc70 = gl.getUniformLocation(prog70,"prMatrix");
// ****** linestrip object 71 ******
var prog71  = gl.createProgram();
gl.attachShader(prog71, getShader( gl, "unnamed_chunk_4vshader71" ));
gl.attachShader(prog71, getShader( gl, "unnamed_chunk_4fshader71" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog71, 0, "aPos");
gl.bindAttribLocation(prog71, 1, "aCol");
gl.linkProgram(prog71);
var v=new Float32Array([
0, 1261, 1.37,
0.455102, 1261, 1.55581,
0.9102041, 1261, 1.750674,
1.365306, 1261, 1.953236,
1.820408, 1261, 2.162081,
2.27551, 1261, 2.37577,
2.730612, 1261, 2.592879,
3.185714, 1261, 2.812022,
3.640816, 1261, 3.031878,
4.095918, 1261, 3.251208,
4.551021, 1261, 3.468872,
5.006123, 1261, 3.683835,
5.461225, 1261, 3.895178,
5.916327, 1261, 4.102094,
6.371428, 1261, 4.303891,
6.82653, 1261, 4.49999,
7.281632, 1261, 4.689915,
7.736735, 1261, 4.873293,
8.191836, 1261, 5.04984,
8.646938, 1261, 5.219358,
9.102041, 1261, 5.381725,
9.557143, 1261, 5.536886,
10.01225, 1261, 5.684844,
10.46735, 1261, 5.825656,
10.92245, 1261, 5.959421,
11.37755, 1261, 6.086275,
11.83265, 1261, 6.206387,
12.28776, 1261, 6.319946,
12.74286, 1261, 6.427167,
13.19796, 1261, 6.528274,
13.65306, 1261, 6.623504,
14.10816, 1261, 6.713102,
14.56326, 1261, 6.797317,
15.01837, 1261, 6.876396,
15.47347, 1261, 6.950591,
15.92857, 1261, 7.020144,
16.38367, 1261, 7.0853,
16.83878, 1261, 7.146294,
17.29388, 1261, 7.203354,
17.74898, 1261, 7.256702,
18.20408, 1261, 7.306553,
18.65918, 1261, 7.353112,
19.11429, 1261, 7.396575,
19.56939, 1261, 7.437131,
20.02449, 1261, 7.474958,
20.47959, 1261, 7.510226,
20.93469, 1261, 7.543097,
21.3898, 1261, 7.573725,
21.8449, 1261, 7.602252,
22.3, 1261, 7.628817
]);
var buf71 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf71);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc71 = gl.getUniformLocation(prog71,"mvMatrix");
var prMatLoc71 = gl.getUniformLocation(prog71,"prMatrix");
// ****** linestrip object 72 ******
var prog72  = gl.createProgram();
gl.attachShader(prog72, getShader( gl, "unnamed_chunk_4vshader72" ));
gl.attachShader(prog72, getShader( gl, "unnamed_chunk_4fshader72" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog72, 0, "aPos");
gl.bindAttribLocation(prog72, 1, "aCol");
gl.linkProgram(prog72);
var v=new Float32Array([
0, 1265, 1.37,
0.455102, 1265, 1.554146,
0.9102041, 1265, 1.746636,
1.365306, 1265, 1.946046,
1.820408, 1265, 2.150914,
2.27551, 1265, 2.359772,
2.730612, 1265, 2.571183,
3.185714, 1265, 2.78377,
3.640816, 1265, 2.996235,
4.095918, 1265, 3.207377,
4.551021, 1265, 3.416108,
5.006123, 1265, 3.621455,
5.461225, 1265, 3.822566,
5.916327, 1265, 4.01871,
6.371428, 1265, 4.209273,
6.82653, 1265, 4.393755,
7.281632, 1265, 4.57176,
7.736735, 1265, 4.74299,
8.191836, 1265, 4.907238,
8.646938, 1265, 5.064375,
9.102041, 1265, 5.214345,
9.557143, 1265, 5.357151,
10.01225, 1265, 5.492855,
10.46735, 1265, 5.62156,
10.92245, 1265, 5.74341,
11.37755, 1265, 5.858579,
11.83265, 1265, 5.967268,
12.28776, 1265, 6.069695,
12.74286, 1265, 6.166095,
13.19796, 1265, 6.256712,
13.65306, 1265, 6.341798,
14.10816, 1265, 6.421607,
14.56326, 1265, 6.496393,
15.01837, 1265, 6.566411,
15.47347, 1265, 6.631911,
15.92857, 1265, 6.693137,
16.38367, 1265, 6.750328,
16.83878, 1265, 6.803713,
17.29388, 1265, 6.853517,
17.74898, 1265, 6.899954,
18.20408, 1265, 6.943228,
18.65918, 1265, 6.983536,
19.11429, 1265, 7.021063,
19.56939, 1265, 7.055989,
20.02449, 1265, 7.08848,
20.47959, 1265, 7.118695,
20.93469, 1265, 7.146785,
21.3898, 1265, 7.172891,
21.8449, 1265, 7.197146,
22.3, 1265, 7.219676
]);
var buf72 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf72);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc72 = gl.getUniformLocation(prog72,"mvMatrix");
var prMatLoc72 = gl.getUniformLocation(prog72,"prMatrix");
// ****** linestrip object 73 ******
var prog73  = gl.createProgram();
gl.attachShader(prog73, getShader( gl, "unnamed_chunk_4vshader73" ));
gl.attachShader(prog73, getShader( gl, "unnamed_chunk_4fshader73" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog73, 0, "aPos");
gl.bindAttribLocation(prog73, 1, "aCol");
gl.linkProgram(prog73);
var v=new Float32Array([
0, 1268, 1.37,
0.455102, 1268, 1.54607,
0.9102041, 1268, 1.72818,
1.365306, 1268, 1.914818,
1.820408, 1268, 2.10449,
2.27551, 1268, 2.295754,
2.730612, 1268, 2.487245,
3.185714, 1268, 2.677705,
3.640816, 1268, 2.865992,
4.095918, 1268, 3.051093,
4.551021, 1268, 3.232125,
5.006123, 1268, 3.40834,
5.461225, 1268, 3.579118,
5.916327, 1268, 3.743963,
6.371428, 1268, 3.90249,
6.82653, 1268, 4.054423,
7.281632, 1268, 4.199578,
7.736735, 1268, 4.337856,
8.191836, 1268, 4.469234,
8.646938, 1268, 4.593747,
9.102041, 1268, 4.711488,
9.557143, 1268, 4.822594,
10.01225, 1268, 4.927237,
10.46735, 1268, 5.02562,
10.92245, 1268, 5.117965,
11.37755, 1268, 5.204515,
11.83265, 1268, 5.28552,
12.28776, 1268, 5.361239,
12.74286, 1268, 5.431935,
13.19796, 1268, 5.497869,
13.65306, 1268, 5.559301,
14.10816, 1268, 5.616486,
14.56326, 1268, 5.669673,
15.01837, 1268, 5.719103,
15.47347, 1268, 5.765008,
15.92857, 1268, 5.807612,
16.38367, 1268, 5.847128,
16.83878, 1268, 5.88376,
17.29388, 1268, 5.9177,
17.74898, 1268, 5.949132,
18.20408, 1268, 5.978228,
18.65918, 1268, 6.00515,
19.11429, 1268, 6.030053,
19.56939, 1268, 6.05308,
20.02449, 1268, 6.074364,
20.47959, 1268, 6.094033,
20.93469, 1268, 6.112205,
21.3898, 1268, 6.128988,
21.8449, 1268, 6.144486,
22.3, 1268, 6.158794
]);
var buf73 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf73);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc73 = gl.getUniformLocation(prog73,"mvMatrix");
var prMatLoc73 = gl.getUniformLocation(prog73,"prMatrix");
// ****** linestrip object 74 ******
var prog74  = gl.createProgram();
gl.attachShader(prog74, getShader( gl, "unnamed_chunk_4vshader74" ));
gl.attachShader(prog74, getShader( gl, "unnamed_chunk_4fshader74" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog74, 0, "aPos");
gl.bindAttribLocation(prog74, 1, "aCol");
gl.linkProgram(prog74);
var v=new Float32Array([
0, 1269, 1.37,
0.455102, 1269, 1.54607,
0.9102041, 1269, 1.72818,
1.365306, 1269, 1.914818,
1.820408, 1269, 2.10449,
2.27551, 1269, 2.295754,
2.730612, 1269, 2.487245,
3.185714, 1269, 2.677705,
3.640816, 1269, 2.865992,
4.095918, 1269, 3.051093,
4.551021, 1269, 3.232125,
5.006123, 1269, 3.40834,
5.461225, 1269, 3.579118,
5.916327, 1269, 3.743963,
6.371428, 1269, 3.90249,
6.82653, 1269, 4.054423,
7.281632, 1269, 4.199578,
7.736735, 1269, 4.337856,
8.191836, 1269, 4.469234,
8.646938, 1269, 4.593747,
9.102041, 1269, 4.711488,
9.557143, 1269, 4.822594,
10.01225, 1269, 4.927237,
10.46735, 1269, 5.02562,
10.92245, 1269, 5.117965,
11.37755, 1269, 5.204515,
11.83265, 1269, 5.28552,
12.28776, 1269, 5.361239,
12.74286, 1269, 5.431935,
13.19796, 1269, 5.497869,
13.65306, 1269, 5.559301,
14.10816, 1269, 5.616486,
14.56326, 1269, 5.669673,
15.01837, 1269, 5.719103,
15.47347, 1269, 5.765008,
15.92857, 1269, 5.807612,
16.38367, 1269, 5.847128,
16.83878, 1269, 5.88376,
17.29388, 1269, 5.9177,
17.74898, 1269, 5.949132,
18.20408, 1269, 5.978228,
18.65918, 1269, 6.00515,
19.11429, 1269, 6.030053,
19.56939, 1269, 6.05308,
20.02449, 1269, 6.074364,
20.47959, 1269, 6.094033,
20.93469, 1269, 6.112205,
21.3898, 1269, 6.128988,
21.8449, 1269, 6.144486,
22.3, 1269, 6.158794
]);
var buf74 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf74);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc74 = gl.getUniformLocation(prog74,"mvMatrix");
var prMatLoc74 = gl.getUniformLocation(prog74,"prMatrix");
// ****** linestrip object 75 ******
var prog75  = gl.createProgram();
gl.attachShader(prog75, getShader( gl, "unnamed_chunk_4vshader75" ));
gl.attachShader(prog75, getShader( gl, "unnamed_chunk_4fshader75" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog75, 0, "aPos");
gl.bindAttribLocation(prog75, 1, "aCol");
gl.linkProgram(prog75);
var v=new Float32Array([
0, 1271, 1.37,
0.455102, 1271, 1.556351,
0.9102041, 1271, 1.752066,
1.365306, 1271, 1.955828,
1.820408, 1271, 2.16625,
2.27551, 1271, 2.381917,
2.730612, 1271, 2.601416,
3.185714, 1271, 2.823365,
3.640816, 1271, 3.046438,
4.095918, 1271, 3.269386,
4.551021, 1271, 3.491049,
5.006123, 1271, 3.710368,
5.461225, 1271, 3.926395,
5.916327, 1271, 4.138291,
6.371428, 1271, 4.345329,
6.82653, 1271, 4.546891,
7.281632, 1271, 4.742468,
7.736735, 1271, 4.931646,
8.191836, 1271, 5.114107,
8.646938, 1271, 5.289617,
9.102041, 1271, 5.458022,
9.557143, 1271, 5.619233,
10.01225, 1271, 5.773229,
10.46735, 1271, 5.920036,
10.92245, 1271, 6.059732,
11.37755, 1271, 6.192433,
11.83265, 1271, 6.318286,
12.28776, 1271, 6.437468,
12.74286, 1271, 6.550176,
13.19796, 1271, 6.656626,
13.65306, 1271, 6.757045,
14.10816, 1271, 6.85167,
14.56326, 1271, 6.940744,
15.01837, 1271, 7.024513,
15.47347, 1271, 7.103222,
15.92857, 1271, 7.177117,
16.38367, 1271, 7.246438,
16.83878, 1271, 7.311423,
17.29388, 1271, 7.372303,
17.74898, 1271, 7.429302,
18.20408, 1271, 7.482636,
18.65918, 1271, 7.532516,
19.11429, 1271, 7.579143,
19.56939, 1271, 7.622707,
20.02449, 1271, 7.663394,
20.47959, 1271, 7.701378,
20.93469, 1271, 7.736827,
21.3898, 1271, 7.769897,
21.8449, 1271, 7.800739,
22.3, 1271, 7.829495
]);
var buf75 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf75);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc75 = gl.getUniformLocation(prog75,"mvMatrix");
var prMatLoc75 = gl.getUniformLocation(prog75,"prMatrix");
// ****** linestrip object 76 ******
var prog76  = gl.createProgram();
gl.attachShader(prog76, getShader( gl, "unnamed_chunk_4vshader76" ));
gl.attachShader(prog76, getShader( gl, "unnamed_chunk_4fshader76" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog76, 0, "aPos");
gl.bindAttribLocation(prog76, 1, "aCol");
gl.linkProgram(prog76);
var v=new Float32Array([
0, 1275, 1.37,
0.455102, 1275, 1.543674,
0.9102041, 1275, 1.722839,
1.365306, 1275, 1.905985,
1.820408, 1275, 2.091629,
2.27551, 1275, 2.278355,
2.730612, 1275, 2.464834,
3.185714, 1275, 2.649849,
3.640816, 1275, 2.832308,
4.095918, 1275, 3.011248,
4.551021, 1275, 3.185845,
5.006123, 1275, 3.355403,
5.461225, 1275, 3.519359,
5.916327, 1275, 3.677268,
6.371428, 1275, 3.828796,
6.82653, 1275, 3.973713,
7.281632, 1275, 4.111879,
7.736735, 1275, 4.243233,
8.191836, 1275, 4.367783,
8.646938, 1275, 4.485597,
9.102041, 1275, 4.596793,
9.557143, 1275, 4.701527,
10.01225, 1275, 4.799991,
10.46735, 1275, 4.892399,
10.92245, 1275, 4.978987,
11.37755, 1275, 5.060001,
11.83265, 1275, 5.1357,
12.28776, 1275, 5.206343,
12.74286, 1275, 5.272194,
13.19796, 1275, 5.333513,
13.65306, 1275, 5.390557,
14.10816, 1275, 5.443578,
14.56326, 1275, 5.492817,
15.01837, 1275, 5.538512,
15.47347, 1275, 5.580888,
15.92857, 1275, 5.62016,
16.38367, 1275, 5.656535,
16.83878, 1275, 5.690209,
17.29388, 1275, 5.721366,
17.74898, 1275, 5.750182,
18.20408, 1275, 5.776821,
18.65918, 1275, 5.801438,
19.11429, 1275, 5.824179,
19.56939, 1275, 5.84518,
20.02449, 1275, 5.864567,
20.47959, 1275, 5.882462,
20.93469, 1275, 5.898972,
21.3898, 1275, 5.914203,
21.8449, 1275, 5.928251,
22.3, 1275, 5.941205
]);
var buf76 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf76);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc76 = gl.getUniformLocation(prog76,"mvMatrix");
var prMatLoc76 = gl.getUniformLocation(prog76,"prMatrix");
// ****** linestrip object 77 ******
var prog77  = gl.createProgram();
gl.attachShader(prog77, getShader( gl, "unnamed_chunk_4vshader77" ));
gl.attachShader(prog77, getShader( gl, "unnamed_chunk_4fshader77" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog77, 0, "aPos");
gl.bindAttribLocation(prog77, 1, "aCol");
gl.linkProgram(prog77);
var v=new Float32Array([
0, 1279, 1.37,
0.455102, 1279, 1.537964,
0.9102041, 1279, 1.710241,
1.365306, 1279, 1.885344,
1.820408, 1279, 2.061843,
2.27551, 1279, 2.238395,
2.730612, 1279, 2.413763,
3.185714, 1279, 2.586836,
3.640816, 1279, 2.756634,
4.095918, 1279, 2.922318,
4.551021, 1279, 3.083182,
5.006123, 1279, 3.238652,
5.461225, 1279, 3.388279,
5.916327, 1279, 3.531726,
6.371428, 1279, 3.668762,
6.82653, 1279, 3.799248,
7.281632, 1279, 3.923126,
7.736735, 1279, 4.040408,
8.191836, 1279, 4.151167,
8.646938, 1279, 4.255523,
9.102041, 1279, 4.353638,
9.557143, 1279, 4.445705,
10.01225, 1279, 4.531943,
10.46735, 1279, 4.612588,
10.92245, 1279, 4.687889,
11.37755, 1279, 4.758102,
11.83265, 1279, 4.823489,
12.28776, 1279, 4.88431,
12.74286, 1279, 4.940824,
13.19796, 1279, 4.993282,
13.65306, 1279, 5.041934,
14.10816, 1279, 5.087017,
14.56326, 1279, 5.128761,
15.01837, 1279, 5.167387,
15.47347, 1279, 5.203104,
15.92857, 1279, 5.236113,
16.38367, 1279, 5.266602,
16.83878, 1279, 5.294749,
17.29388, 1279, 5.320723,
17.74898, 1279, 5.344681,
18.20408, 1279, 5.366771,
18.65918, 1279, 5.387132,
19.11429, 1279, 5.405892,
19.56939, 1279, 5.423174,
20.02449, 1279, 5.439088,
20.47959, 1279, 5.45374,
20.93469, 1279, 5.467226,
21.3898, 1279, 5.479636,
21.8449, 1279, 5.491054,
22.3, 1279, 5.501558
]);
var buf77 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf77);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc77 = gl.getUniformLocation(prog77,"mvMatrix");
var prMatLoc77 = gl.getUniformLocation(prog77,"prMatrix");
// ****** linestrip object 78 ******
var prog78  = gl.createProgram();
gl.attachShader(prog78, getShader( gl, "unnamed_chunk_4vshader78" ));
gl.attachShader(prog78, getShader( gl, "unnamed_chunk_4fshader78" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog78, 0, "aPos");
gl.bindAttribLocation(prog78, 1, "aCol");
gl.linkProgram(prog78);
var v=new Float32Array([
0, 1295, 1.37,
0.455102, 1295, 1.526758,
0.9102041, 1295, 1.685888,
1.365306, 1295, 1.846013,
1.820408, 1295, 2.005848,
2.27551, 1295, 2.164223,
2.730612, 1295, 2.320099,
3.185714, 1295, 2.472571,
3.640816, 1295, 2.620874,
4.095918, 1295, 2.764379,
4.551021, 1295, 2.902587,
5.006123, 1295, 3.035117,
5.461225, 1295, 3.161702,
5.916327, 1295, 3.28217,
6.371428, 1295, 3.396438,
6.82653, 1295, 3.504495,
7.281632, 1295, 3.606396,
7.736735, 1295, 3.702247,
8.191836, 1295, 3.792198,
8.646938, 1295, 3.876434,
9.102041, 1295, 3.955162,
9.557143, 1295, 4.028612,
10.01225, 1295, 4.097027,
10.46735, 1295, 4.160655,
10.92245, 1295, 4.219752,
11.37755, 1295, 4.274571,
11.83265, 1295, 4.325364,
12.28776, 1295, 4.372377,
12.74286, 1295, 4.41585,
13.19796, 1295, 4.456013,
13.65306, 1295, 4.49309,
14.10816, 1295, 4.527291,
14.56326, 1295, 4.55882,
15.01837, 1295, 4.587866,
15.47347, 1295, 4.614611,
15.92857, 1295, 4.639224,
16.38367, 1295, 4.661864,
16.83878, 1295, 4.68268,
17.29388, 1295, 4.701811,
17.74898, 1295, 4.719389,
18.20408, 1295, 4.735533,
18.65918, 1295, 4.750356,
19.11429, 1295, 4.763962,
19.56939, 1295, 4.776448,
20.02449, 1295, 4.787903,
20.47959, 1295, 4.798411,
20.93469, 1295, 4.808048,
21.3898, 1295, 4.816885,
21.8449, 1295, 4.824985,
22.3, 1295, 4.832411
]);
var buf78 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf78);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc78 = gl.getUniformLocation(prog78,"mvMatrix");
var prMatLoc78 = gl.getUniformLocation(prog78,"prMatrix");
// ****** linestrip object 79 ******
var prog79  = gl.createProgram();
gl.attachShader(prog79, getShader( gl, "unnamed_chunk_4vshader79" ));
gl.attachShader(prog79, getShader( gl, "unnamed_chunk_4fshader79" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog79, 0, "aPos");
gl.bindAttribLocation(prog79, 1, "aCol");
gl.linkProgram(prog79);
var v=new Float32Array([
0, 1295, 1.37,
0.455102, 1295, 1.534607,
0.9102041, 1295, 1.702899,
1.365306, 1295, 1.873418,
1.820408, 1295, 2.044772,
2.27551, 1295, 2.215665,
2.730612, 1295, 2.38492,
3.185714, 1295, 2.551487,
3.640816, 1295, 2.714455,
4.095918, 1295, 2.873048,
4.551021, 1295, 3.026627,
5.006123, 1295, 3.174681,
5.461225, 1295, 3.316822,
5.916327, 1295, 3.452767,
6.371428, 1295, 3.582336,
6.82653, 1295, 3.705435,
7.281632, 1295, 3.822045,
7.736735, 1295, 3.932211,
8.191836, 1295, 4.036035,
8.646938, 1295, 4.133661,
9.102041, 1295, 4.225268,
9.557143, 1295, 4.311066,
10.01225, 1295, 4.391282,
10.46735, 1295, 4.46616,
10.92245, 1295, 4.535953,
11.37755, 1295, 4.600919,
11.83265, 1295, 4.661317,
12.28776, 1295, 4.717405,
12.74286, 1295, 4.769437,
13.19796, 1295, 4.817661,
13.65306, 1295, 4.862315,
14.10816, 1295, 4.903632,
14.56326, 1295, 4.941832,
15.01837, 1295, 4.977128,
15.47347, 1295, 5.009718,
15.92857, 1295, 5.039795,
16.38367, 1295, 5.067538,
16.83878, 1295, 5.093115,
17.29388, 1295, 5.116685,
17.74898, 1295, 5.138398,
18.20408, 1295, 5.158391,
18.65918, 1295, 5.176796,
19.11429, 1295, 5.193733,
19.56939, 1295, 5.209314,
20.02449, 1295, 5.223645,
20.47959, 1295, 5.236823,
20.93469, 1295, 5.248937,
21.3898, 1295, 5.260072,
21.8449, 1295, 5.270305,
22.3, 1295, 5.279706
]);
var buf79 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf79);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc79 = gl.getUniformLocation(prog79,"mvMatrix");
var prMatLoc79 = gl.getUniformLocation(prog79,"prMatrix");
// ****** linestrip object 80 ******
var prog80  = gl.createProgram();
gl.attachShader(prog80, getShader( gl, "unnamed_chunk_4vshader80" ));
gl.attachShader(prog80, getShader( gl, "unnamed_chunk_4fshader80" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog80, 0, "aPos");
gl.bindAttribLocation(prog80, 1, "aCol");
gl.linkProgram(prog80);
var v=new Float32Array([
0, 1299, 1.37,
0.455102, 1299, 1.54607,
0.9102041, 1299, 1.72818,
1.365306, 1299, 1.914818,
1.820408, 1299, 2.10449,
2.27551, 1299, 2.295754,
2.730612, 1299, 2.487245,
3.185714, 1299, 2.677705,
3.640816, 1299, 2.865992,
4.095918, 1299, 3.051093,
4.551021, 1299, 3.232125,
5.006123, 1299, 3.40834,
5.461225, 1299, 3.579118,
5.916327, 1299, 3.743963,
6.371428, 1299, 3.90249,
6.82653, 1299, 4.054423,
7.281632, 1299, 4.199578,
7.736735, 1299, 4.337856,
8.191836, 1299, 4.469234,
8.646938, 1299, 4.593747,
9.102041, 1299, 4.711488,
9.557143, 1299, 4.822594,
10.01225, 1299, 4.927237,
10.46735, 1299, 5.02562,
10.92245, 1299, 5.117965,
11.37755, 1299, 5.204515,
11.83265, 1299, 5.28552,
12.28776, 1299, 5.361239,
12.74286, 1299, 5.431935,
13.19796, 1299, 5.497869,
13.65306, 1299, 5.559301,
14.10816, 1299, 5.616486,
14.56326, 1299, 5.669673,
15.01837, 1299, 5.719103,
15.47347, 1299, 5.765008,
15.92857, 1299, 5.807612,
16.38367, 1299, 5.847128,
16.83878, 1299, 5.88376,
17.29388, 1299, 5.9177,
17.74898, 1299, 5.949132,
18.20408, 1299, 5.978228,
18.65918, 1299, 6.00515,
19.11429, 1299, 6.030053,
19.56939, 1299, 6.05308,
20.02449, 1299, 6.074364,
20.47959, 1299, 6.094033,
20.93469, 1299, 6.112205,
21.3898, 1299, 6.128988,
21.8449, 1299, 6.144486,
22.3, 1299, 6.158794
]);
var buf80 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf80);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc80 = gl.getUniformLocation(prog80,"mvMatrix");
var prMatLoc80 = gl.getUniformLocation(prog80,"prMatrix");
// ****** linestrip object 81 ******
var prog81  = gl.createProgram();
gl.attachShader(prog81, getShader( gl, "unnamed_chunk_4vshader81" ));
gl.attachShader(prog81, getShader( gl, "unnamed_chunk_4fshader81" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog81, 0, "aPos");
gl.bindAttribLocation(prog81, 1, "aCol");
gl.linkProgram(prog81);
var v=new Float32Array([
0, 1302, 1.37,
0.455102, 1302, 1.537964,
0.9102041, 1302, 1.710241,
1.365306, 1302, 1.885344,
1.820408, 1302, 2.061843,
2.27551, 1302, 2.238395,
2.730612, 1302, 2.413763,
3.185714, 1302, 2.586836,
3.640816, 1302, 2.756634,
4.095918, 1302, 2.922318,
4.551021, 1302, 3.083182,
5.006123, 1302, 3.238652,
5.461225, 1302, 3.388279,
5.916327, 1302, 3.531726,
6.371428, 1302, 3.668762,
6.82653, 1302, 3.799248,
7.281632, 1302, 3.923126,
7.736735, 1302, 4.040408,
8.191836, 1302, 4.151167,
8.646938, 1302, 4.255523,
9.102041, 1302, 4.353638,
9.557143, 1302, 4.445705,
10.01225, 1302, 4.531943,
10.46735, 1302, 4.612588,
10.92245, 1302, 4.687889,
11.37755, 1302, 4.758102,
11.83265, 1302, 4.823489,
12.28776, 1302, 4.88431,
12.74286, 1302, 4.940824,
13.19796, 1302, 4.993282,
13.65306, 1302, 5.041934,
14.10816, 1302, 5.087017,
14.56326, 1302, 5.128761,
15.01837, 1302, 5.167387,
15.47347, 1302, 5.203104,
15.92857, 1302, 5.236113,
16.38367, 1302, 5.266602,
16.83878, 1302, 5.294749,
17.29388, 1302, 5.320723,
17.74898, 1302, 5.344681,
18.20408, 1302, 5.366771,
18.65918, 1302, 5.387132,
19.11429, 1302, 5.405892,
19.56939, 1302, 5.423174,
20.02449, 1302, 5.439088,
20.47959, 1302, 5.45374,
20.93469, 1302, 5.467226,
21.3898, 1302, 5.479636,
21.8449, 1302, 5.491054,
22.3, 1302, 5.501558
]);
var buf81 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf81);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc81 = gl.getUniformLocation(prog81,"mvMatrix");
var prMatLoc81 = gl.getUniformLocation(prog81,"prMatrix");
// ****** linestrip object 82 ******
var prog82  = gl.createProgram();
gl.attachShader(prog82, getShader( gl, "unnamed_chunk_4vshader82" ));
gl.attachShader(prog82, getShader( gl, "unnamed_chunk_4fshader82" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog82, 0, "aPos");
gl.bindAttribLocation(prog82, 1, "aCol");
gl.linkProgram(prog82);
var v=new Float32Array([
0, 1305, 1.37,
0.455102, 1305, 1.543674,
0.9102041, 1305, 1.722839,
1.365306, 1305, 1.905985,
1.820408, 1305, 2.091629,
2.27551, 1305, 2.278355,
2.730612, 1305, 2.464834,
3.185714, 1305, 2.649849,
3.640816, 1305, 2.832308,
4.095918, 1305, 3.011248,
4.551021, 1305, 3.185845,
5.006123, 1305, 3.355403,
5.461225, 1305, 3.519359,
5.916327, 1305, 3.677268,
6.371428, 1305, 3.828796,
6.82653, 1305, 3.973713,
7.281632, 1305, 4.111879,
7.736735, 1305, 4.243233,
8.191836, 1305, 4.367783,
8.646938, 1305, 4.485597,
9.102041, 1305, 4.596793,
9.557143, 1305, 4.701527,
10.01225, 1305, 4.799991,
10.46735, 1305, 4.892399,
10.92245, 1305, 4.978987,
11.37755, 1305, 5.060001,
11.83265, 1305, 5.1357,
12.28776, 1305, 5.206343,
12.74286, 1305, 5.272194,
13.19796, 1305, 5.333513,
13.65306, 1305, 5.390557,
14.10816, 1305, 5.443578,
14.56326, 1305, 5.492817,
15.01837, 1305, 5.538512,
15.47347, 1305, 5.580888,
15.92857, 1305, 5.62016,
16.38367, 1305, 5.656535,
16.83878, 1305, 5.690209,
17.29388, 1305, 5.721366,
17.74898, 1305, 5.750182,
18.20408, 1305, 5.776821,
18.65918, 1305, 5.801438,
19.11429, 1305, 5.824179,
19.56939, 1305, 5.84518,
20.02449, 1305, 5.864567,
20.47959, 1305, 5.882462,
20.93469, 1305, 5.898972,
21.3898, 1305, 5.914203,
21.8449, 1305, 5.928251,
22.3, 1305, 5.941205
]);
var buf82 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf82);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc82 = gl.getUniformLocation(prog82,"mvMatrix");
var prMatLoc82 = gl.getUniformLocation(prog82,"prMatrix");
// ****** linestrip object 83 ******
var prog83  = gl.createProgram();
gl.attachShader(prog83, getShader( gl, "unnamed_chunk_4vshader83" ));
gl.attachShader(prog83, getShader( gl, "unnamed_chunk_4fshader83" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog83, 0, "aPos");
gl.bindAttribLocation(prog83, 1, "aCol");
gl.linkProgram(prog83);
var v=new Float32Array([
0, 1310, 1.37,
0.455102, 1310, 1.543674,
0.9102041, 1310, 1.722839,
1.365306, 1310, 1.905985,
1.820408, 1310, 2.091629,
2.27551, 1310, 2.278355,
2.730612, 1310, 2.464834,
3.185714, 1310, 2.649849,
3.640816, 1310, 2.832308,
4.095918, 1310, 3.011248,
4.551021, 1310, 3.185845,
5.006123, 1310, 3.355403,
5.461225, 1310, 3.519359,
5.916327, 1310, 3.677268,
6.371428, 1310, 3.828796,
6.82653, 1310, 3.973713,
7.281632, 1310, 4.111879,
7.736735, 1310, 4.243233,
8.191836, 1310, 4.367783,
8.646938, 1310, 4.485597,
9.102041, 1310, 4.596793,
9.557143, 1310, 4.701527,
10.01225, 1310, 4.799991,
10.46735, 1310, 4.892399,
10.92245, 1310, 4.978987,
11.37755, 1310, 5.060001,
11.83265, 1310, 5.1357,
12.28776, 1310, 5.206343,
12.74286, 1310, 5.272194,
13.19796, 1310, 5.333513,
13.65306, 1310, 5.390557,
14.10816, 1310, 5.443578,
14.56326, 1310, 5.492817,
15.01837, 1310, 5.538512,
15.47347, 1310, 5.580888,
15.92857, 1310, 5.62016,
16.38367, 1310, 5.656535,
16.83878, 1310, 5.690209,
17.29388, 1310, 5.721366,
17.74898, 1310, 5.750182,
18.20408, 1310, 5.776821,
18.65918, 1310, 5.801438,
19.11429, 1310, 5.824179,
19.56939, 1310, 5.84518,
20.02449, 1310, 5.864567,
20.47959, 1310, 5.882462,
20.93469, 1310, 5.898972,
21.3898, 1310, 5.914203,
21.8449, 1310, 5.928251,
22.3, 1310, 5.941205
]);
var buf83 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf83);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc83 = gl.getUniformLocation(prog83,"mvMatrix");
var prMatLoc83 = gl.getUniformLocation(prog83,"prMatrix");
// ****** linestrip object 84 ******
var prog84  = gl.createProgram();
gl.attachShader(prog84, getShader( gl, "unnamed_chunk_4vshader84" ));
gl.attachShader(prog84, getShader( gl, "unnamed_chunk_4fshader84" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog84, 0, "aPos");
gl.bindAttribLocation(prog84, 1, "aCol");
gl.linkProgram(prog84);
var v=new Float32Array([
0, 1320, 1.37,
0.455102, 1320, 1.550035,
0.9102041, 1320, 1.737122,
1.365306, 1320, 1.929767,
1.820408, 1320, 2.126471,
2.27551, 1320, 2.325762,
2.730612, 1320, 2.526229,
3.185714, 1320, 2.726547,
3.640816, 1320, 2.925493,
4.095918, 1320, 3.121964,
4.551021, 1320, 3.314983,
5.006123, 1320, 3.503699,
5.461225, 1320, 3.687391,
5.916327, 1320, 3.865461,
6.371428, 1320, 4.037428,
6.82653, 1320, 4.202924,
7.281632, 1320, 4.361679,
7.736735, 1320, 4.513514,
8.191836, 1320, 4.658335,
8.646938, 1320, 4.796114,
9.102041, 1320, 4.926888,
9.557143, 1320, 5.050746,
10.01225, 1320, 5.167819,
10.46735, 1320, 5.278277,
10.92245, 1320, 5.382316,
11.37755, 1320, 5.480155,
11.83265, 1320, 5.572032,
12.28776, 1320, 5.658195,
12.74286, 1320, 5.738898,
13.19796, 1320, 5.814404,
13.65306, 1320, 5.884971,
14.10816, 1320, 5.95086,
14.56326, 1320, 6.012325,
15.01837, 1320, 6.069616,
15.47347, 1320, 6.122977,
15.92857, 1320, 6.172641,
16.38367, 1320, 6.218835,
16.83878, 1320, 6.261776,
17.29388, 1320, 6.301671,
17.74898, 1320, 6.338716,
18.20408, 1320, 6.3731,
18.65918, 1320, 6.404999,
19.11429, 1320, 6.434581,
19.56939, 1320, 6.462005,
20.02449, 1320, 6.48742,
20.47959, 1320, 6.510963,
20.93469, 1320, 6.532769,
21.3898, 1320, 6.552959,
21.8449, 1320, 6.571648,
22.3, 1320, 6.588944
]);
var buf84 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf84);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc84 = gl.getUniformLocation(prog84,"mvMatrix");
var prMatLoc84 = gl.getUniformLocation(prog84,"prMatrix");
// ****** linestrip object 85 ******
var prog85  = gl.createProgram();
gl.attachShader(prog85, getShader( gl, "unnamed_chunk_4vshader85" ));
gl.attachShader(prog85, getShader( gl, "unnamed_chunk_4fshader85" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog85, 0, "aPos");
gl.bindAttribLocation(prog85, 1, "aCol");
gl.linkProgram(prog85);
var v=new Float32Array([
0, 1321, 1.37,
0.455102, 1321, 1.550035,
0.9102041, 1321, 1.737122,
1.365306, 1321, 1.929767,
1.820408, 1321, 2.126471,
2.27551, 1321, 2.325762,
2.730612, 1321, 2.526229,
3.185714, 1321, 2.726547,
3.640816, 1321, 2.925493,
4.095918, 1321, 3.121964,
4.551021, 1321, 3.314983,
5.006123, 1321, 3.503699,
5.461225, 1321, 3.687391,
5.916327, 1321, 3.865461,
6.371428, 1321, 4.037428,
6.82653, 1321, 4.202924,
7.281632, 1321, 4.361679,
7.736735, 1321, 4.513514,
8.191836, 1321, 4.658335,
8.646938, 1321, 4.796114,
9.102041, 1321, 4.926888,
9.557143, 1321, 5.050746,
10.01225, 1321, 5.167819,
10.46735, 1321, 5.278277,
10.92245, 1321, 5.382316,
11.37755, 1321, 5.480155,
11.83265, 1321, 5.572032,
12.28776, 1321, 5.658195,
12.74286, 1321, 5.738898,
13.19796, 1321, 5.814404,
13.65306, 1321, 5.884971,
14.10816, 1321, 5.95086,
14.56326, 1321, 6.012325,
15.01837, 1321, 6.069616,
15.47347, 1321, 6.122977,
15.92857, 1321, 6.172641,
16.38367, 1321, 6.218835,
16.83878, 1321, 6.261776,
17.29388, 1321, 6.301671,
17.74898, 1321, 6.338716,
18.20408, 1321, 6.3731,
18.65918, 1321, 6.404999,
19.11429, 1321, 6.434581,
19.56939, 1321, 6.462005,
20.02449, 1321, 6.48742,
20.47959, 1321, 6.510963,
20.93469, 1321, 6.532769,
21.3898, 1321, 6.552959,
21.8449, 1321, 6.571648,
22.3, 1321, 6.588944
]);
var buf85 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf85);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc85 = gl.getUniformLocation(prog85,"mvMatrix");
var prMatLoc85 = gl.getUniformLocation(prog85,"prMatrix");
// ****** linestrip object 86 ******
var prog86  = gl.createProgram();
gl.attachShader(prog86, getShader( gl, "unnamed_chunk_4vshader86" ));
gl.attachShader(prog86, getShader( gl, "unnamed_chunk_4fshader86" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog86, 0, "aPos");
gl.bindAttribLocation(prog86, 1, "aCol");
gl.linkProgram(prog86);
var v=new Float32Array([
0, 1325, 1.37,
0.455102, 1325, 1.553003,
0.9102041, 1325, 1.743949,
1.365306, 1325, 1.941387,
1.820408, 1325, 2.143836,
2.27551, 1325, 2.349823,
2.730612, 1325, 2.557913,
3.185714, 1325, 2.76674,
3.640816, 1325, 2.975025,
4.095918, 1325, 3.181596,
4.551021, 1325, 3.385396,
5.006123, 1325, 3.585489,
5.461225, 1325, 3.781063,
5.916327, 1325, 3.97143,
6.371428, 1325, 4.156017,
6.82653, 1325, 4.334367,
7.281632, 1325, 4.506126,
7.736735, 1325, 4.671035,
8.191836, 1325, 4.828924,
8.646938, 1325, 4.979699,
9.102041, 1325, 5.123336,
9.557143, 1325, 5.259869,
10.01225, 1325, 5.389381,
10.46735, 1325, 5.512003,
10.92245, 1325, 5.627895,
11.37755, 1325, 5.73725,
11.83265, 1325, 5.840281,
12.28776, 1325, 5.937219,
12.74286, 1325, 6.028306,
13.19796, 1325, 6.113795,
13.65306, 1325, 6.193941,
14.10816, 1325, 6.269001,
14.56326, 1325, 6.339233,
15.01837, 1325, 6.404889,
15.47347, 1325, 6.466218,
15.92857, 1325, 6.523463,
16.38367, 1325, 6.576859,
16.83878, 1325, 6.626633,
17.29388, 1325, 6.673004,
17.74898, 1325, 6.716179,
18.20408, 1325, 6.756361,
18.65918, 1325, 6.793738,
19.11429, 1325, 6.828491,
19.56939, 1325, 6.860792,
20.02449, 1325, 6.890802,
20.47959, 1325, 6.918675,
20.93469, 1325, 6.944555,
21.3898, 1325, 6.968577,
21.8449, 1325, 6.990869,
22.3, 1325, 7.011549
]);
var buf86 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf86);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc86 = gl.getUniformLocation(prog86,"mvMatrix");
var prMatLoc86 = gl.getUniformLocation(prog86,"prMatrix");
// ****** linestrip object 87 ******
var prog87  = gl.createProgram();
gl.attachShader(prog87, getShader( gl, "unnamed_chunk_4vshader87" ));
gl.attachShader(prog87, getShader( gl, "unnamed_chunk_4fshader87" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog87, 0, "aPos");
gl.bindAttribLocation(prog87, 1, "aCol");
gl.linkProgram(prog87);
var v=new Float32Array([
0, 1325, 1.37,
0.455102, 1325, 1.543674,
0.9102041, 1325, 1.722839,
1.365306, 1325, 1.905985,
1.820408, 1325, 2.091629,
2.27551, 1325, 2.278355,
2.730612, 1325, 2.464834,
3.185714, 1325, 2.649849,
3.640816, 1325, 2.832308,
4.095918, 1325, 3.011248,
4.551021, 1325, 3.185845,
5.006123, 1325, 3.355403,
5.461225, 1325, 3.519359,
5.916327, 1325, 3.677268,
6.371428, 1325, 3.828796,
6.82653, 1325, 3.973713,
7.281632, 1325, 4.111879,
7.736735, 1325, 4.243233,
8.191836, 1325, 4.367783,
8.646938, 1325, 4.485597,
9.102041, 1325, 4.596793,
9.557143, 1325, 4.701527,
10.01225, 1325, 4.799991,
10.46735, 1325, 4.892399,
10.92245, 1325, 4.978987,
11.37755, 1325, 5.060001,
11.83265, 1325, 5.1357,
12.28776, 1325, 5.206343,
12.74286, 1325, 5.272194,
13.19796, 1325, 5.333513,
13.65306, 1325, 5.390557,
14.10816, 1325, 5.443578,
14.56326, 1325, 5.492817,
15.01837, 1325, 5.538512,
15.47347, 1325, 5.580888,
15.92857, 1325, 5.62016,
16.38367, 1325, 5.656535,
16.83878, 1325, 5.690209,
17.29388, 1325, 5.721366,
17.74898, 1325, 5.750182,
18.20408, 1325, 5.776821,
18.65918, 1325, 5.801438,
19.11429, 1325, 5.824179,
19.56939, 1325, 5.84518,
20.02449, 1325, 5.864567,
20.47959, 1325, 5.882462,
20.93469, 1325, 5.898972,
21.3898, 1325, 5.914203,
21.8449, 1325, 5.928251,
22.3, 1325, 5.941205
]);
var buf87 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf87);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc87 = gl.getUniformLocation(prog87,"mvMatrix");
var prMatLoc87 = gl.getUniformLocation(prog87,"prMatrix");
// ****** linestrip object 88 ******
var prog88  = gl.createProgram();
gl.attachShader(prog88, getShader( gl, "unnamed_chunk_4vshader88" ));
gl.attachShader(prog88, getShader( gl, "unnamed_chunk_4fshader88" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog88, 0, "aPos");
gl.bindAttribLocation(prog88, 1, "aCol");
gl.linkProgram(prog88);
var v=new Float32Array([
0, 1329, 1.37,
0.455102, 1329, 1.54607,
0.9102041, 1329, 1.72818,
1.365306, 1329, 1.914818,
1.820408, 1329, 2.10449,
2.27551, 1329, 2.295754,
2.730612, 1329, 2.487245,
3.185714, 1329, 2.677705,
3.640816, 1329, 2.865992,
4.095918, 1329, 3.051093,
4.551021, 1329, 3.232125,
5.006123, 1329, 3.40834,
5.461225, 1329, 3.579118,
5.916327, 1329, 3.743963,
6.371428, 1329, 3.90249,
6.82653, 1329, 4.054423,
7.281632, 1329, 4.199578,
7.736735, 1329, 4.337856,
8.191836, 1329, 4.469234,
8.646938, 1329, 4.593747,
9.102041, 1329, 4.711488,
9.557143, 1329, 4.822594,
10.01225, 1329, 4.927237,
10.46735, 1329, 5.02562,
10.92245, 1329, 5.117965,
11.37755, 1329, 5.204515,
11.83265, 1329, 5.28552,
12.28776, 1329, 5.361239,
12.74286, 1329, 5.431935,
13.19796, 1329, 5.497869,
13.65306, 1329, 5.559301,
14.10816, 1329, 5.616486,
14.56326, 1329, 5.669673,
15.01837, 1329, 5.719103,
15.47347, 1329, 5.765008,
15.92857, 1329, 5.807612,
16.38367, 1329, 5.847128,
16.83878, 1329, 5.88376,
17.29388, 1329, 5.9177,
17.74898, 1329, 5.949132,
18.20408, 1329, 5.978228,
18.65918, 1329, 6.00515,
19.11429, 1329, 6.030053,
19.56939, 1329, 6.05308,
20.02449, 1329, 6.074364,
20.47959, 1329, 6.094033,
20.93469, 1329, 6.112205,
21.3898, 1329, 6.128988,
21.8449, 1329, 6.144486,
22.3, 1329, 6.158794
]);
var buf88 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf88);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc88 = gl.getUniformLocation(prog88,"mvMatrix");
var prMatLoc88 = gl.getUniformLocation(prog88,"prMatrix");
// ****** linestrip object 89 ******
var prog89  = gl.createProgram();
gl.attachShader(prog89, getShader( gl, "unnamed_chunk_4vshader89" ));
gl.attachShader(prog89, getShader( gl, "unnamed_chunk_4fshader89" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog89, 0, "aPos");
gl.bindAttribLocation(prog89, 1, "aCol");
gl.linkProgram(prog89);
var v=new Float32Array([
0, 1332, 1.37,
0.455102, 1332, 1.551637,
0.9102041, 1332, 1.740786,
1.365306, 1332, 1.935973,
1.820408, 1332, 2.135705,
2.27551, 1332, 2.338506,
2.730612, 1332, 2.54295,
3.185714, 1332, 2.747688,
3.640816, 1332, 2.951468,
4.095918, 1332, 3.153148,
4.551021, 1332, 3.35171,
5.006123, 1332, 3.546258,
5.461225, 1332, 3.736023,
5.916327, 1332, 3.920362,
6.371428, 1332, 4.098748,
6.82653, 1332, 4.270765,
7.281632, 1332, 4.436103,
7.736735, 1332, 4.594543,
8.191836, 1332, 4.745951,
8.646938, 1332, 4.890269,
9.102041, 1332, 5.027503,
9.557143, 1332, 5.157715,
10.01225, 1332, 5.281013,
10.46735, 1332, 5.397548,
10.92245, 1332, 5.507499,
11.37755, 1332, 5.611073,
11.83265, 1332, 5.708497,
12.28776, 1332, 5.80001,
12.74286, 1332, 5.885863,
13.19796, 1332, 5.966311,
13.65306, 1332, 6.041616,
14.10816, 1332, 6.112034,
14.56326, 1332, 6.177824,
15.01837, 1332, 6.239236,
15.47347, 1332, 6.296518,
15.92857, 1332, 6.349909,
16.38367, 1332, 6.399639,
16.83878, 1332, 6.445931,
17.29388, 1332, 6.488998,
17.74898, 1332, 6.529044,
18.20408, 1332, 6.566262,
18.65918, 1332, 6.600836,
19.11429, 1332, 6.632942,
19.56939, 1332, 6.662743,
20.02449, 1332, 6.690395,
20.47959, 1332, 6.716046,
20.93469, 1332, 6.739832,
21.3898, 1332, 6.761883,
21.8449, 1332, 6.78232,
22.3, 1332, 6.801257
]);
var buf89 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf89);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc89 = gl.getUniformLocation(prog89,"mvMatrix");
var prMatLoc89 = gl.getUniformLocation(prog89,"prMatrix");
// ****** linestrip object 90 ******
var prog90  = gl.createProgram();
gl.attachShader(prog90, getShader( gl, "unnamed_chunk_4vshader90" ));
gl.attachShader(prog90, getShader( gl, "unnamed_chunk_4fshader90" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog90, 0, "aPos");
gl.bindAttribLocation(prog90, 1, "aCol");
gl.linkProgram(prog90);
var v=new Float32Array([
0, 1335, 1.37,
0.455102, 1335, 1.551637,
0.9102041, 1335, 1.740786,
1.365306, 1335, 1.935973,
1.820408, 1335, 2.135705,
2.27551, 1335, 2.338506,
2.730612, 1335, 2.54295,
3.185714, 1335, 2.747688,
3.640816, 1335, 2.951468,
4.095918, 1335, 3.153148,
4.551021, 1335, 3.35171,
5.006123, 1335, 3.546258,
5.461225, 1335, 3.736023,
5.916327, 1335, 3.920362,
6.371428, 1335, 4.098748,
6.82653, 1335, 4.270765,
7.281632, 1335, 4.436103,
7.736735, 1335, 4.594543,
8.191836, 1335, 4.745951,
8.646938, 1335, 4.890269,
9.102041, 1335, 5.027503,
9.557143, 1335, 5.157715,
10.01225, 1335, 5.281013,
10.46735, 1335, 5.397548,
10.92245, 1335, 5.507499,
11.37755, 1335, 5.611073,
11.83265, 1335, 5.708497,
12.28776, 1335, 5.80001,
12.74286, 1335, 5.885863,
13.19796, 1335, 5.966311,
13.65306, 1335, 6.041616,
14.10816, 1335, 6.112034,
14.56326, 1335, 6.177824,
15.01837, 1335, 6.239236,
15.47347, 1335, 6.296518,
15.92857, 1335, 6.349909,
16.38367, 1335, 6.399639,
16.83878, 1335, 6.445931,
17.29388, 1335, 6.488998,
17.74898, 1335, 6.529044,
18.20408, 1335, 6.566262,
18.65918, 1335, 6.600836,
19.11429, 1335, 6.632942,
19.56939, 1335, 6.662743,
20.02449, 1335, 6.690395,
20.47959, 1335, 6.716046,
20.93469, 1335, 6.739832,
21.3898, 1335, 6.761883,
21.8449, 1335, 6.78232,
22.3, 1335, 6.801257
]);
var buf90 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf90);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc90 = gl.getUniformLocation(prog90,"mvMatrix");
var prMatLoc90 = gl.getUniformLocation(prog90,"prMatrix");
// ****** linestrip object 91 ******
var prog91  = gl.createProgram();
gl.attachShader(prog91, getShader( gl, "unnamed_chunk_4vshader91" ));
gl.attachShader(prog91, getShader( gl, "unnamed_chunk_4fshader91" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog91, 0, "aPos");
gl.bindAttribLocation(prog91, 1, "aCol");
gl.linkProgram(prog91);
var v=new Float32Array([
0, 1351, 1.37,
0.455102, 1351, 1.534607,
0.9102041, 1351, 1.702899,
1.365306, 1351, 1.873418,
1.820408, 1351, 2.044772,
2.27551, 1351, 2.215665,
2.730612, 1351, 2.38492,
3.185714, 1351, 2.551487,
3.640816, 1351, 2.714455,
4.095918, 1351, 2.873048,
4.551021, 1351, 3.026627,
5.006123, 1351, 3.174681,
5.461225, 1351, 3.316822,
5.916327, 1351, 3.452767,
6.371428, 1351, 3.582336,
6.82653, 1351, 3.705435,
7.281632, 1351, 3.822045,
7.736735, 1351, 3.932211,
8.191836, 1351, 4.036035,
8.646938, 1351, 4.133661,
9.102041, 1351, 4.225268,
9.557143, 1351, 4.311066,
10.01225, 1351, 4.391282,
10.46735, 1351, 4.46616,
10.92245, 1351, 4.535953,
11.37755, 1351, 4.600919,
11.83265, 1351, 4.661317,
12.28776, 1351, 4.717405,
12.74286, 1351, 4.769437,
13.19796, 1351, 4.817661,
13.65306, 1351, 4.862315,
14.10816, 1351, 4.903632,
14.56326, 1351, 4.941832,
15.01837, 1351, 4.977128,
15.47347, 1351, 5.009718,
15.92857, 1351, 5.039795,
16.38367, 1351, 5.067538,
16.83878, 1351, 5.093115,
17.29388, 1351, 5.116685,
17.74898, 1351, 5.138398,
18.20408, 1351, 5.158391,
18.65918, 1351, 5.176796,
19.11429, 1351, 5.193733,
19.56939, 1351, 5.209314,
20.02449, 1351, 5.223645,
20.47959, 1351, 5.236823,
20.93469, 1351, 5.248937,
21.3898, 1351, 5.260072,
21.8449, 1351, 5.270305,
22.3, 1351, 5.279706
]);
var buf91 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf91);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc91 = gl.getUniformLocation(prog91,"mvMatrix");
var prMatLoc91 = gl.getUniformLocation(prog91,"prMatrix");
// ****** linestrip object 92 ******
var prog92  = gl.createProgram();
gl.attachShader(prog92, getShader( gl, "unnamed_chunk_4vshader92" ));
gl.attachShader(prog92, getShader( gl, "unnamed_chunk_4fshader92" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog92, 0, "aPos");
gl.bindAttribLocation(prog92, 1, "aCol");
gl.linkProgram(prog92);
var v=new Float32Array([
0, 1355, 1.37,
0.455102, 1355, 1.491458,
0.9102041, 1355, 1.611235,
1.365306, 1355, 1.728492,
1.820408, 1355, 1.842517,
2.27551, 1355, 1.952729,
2.730612, 1355, 2.058668,
3.185714, 1355, 2.15999,
3.640816, 1355, 2.256456,
4.095918, 1355, 2.347916,
4.551021, 1355, 2.434304,
5.006123, 1355, 2.515622,
5.461225, 1355, 2.591927,
5.916327, 1355, 2.663327,
6.371428, 1355, 2.729964,
6.82653, 1355, 2.792009,
7.281632, 1355, 2.849657,
7.736735, 1355, 2.903114,
8.191836, 1355, 2.952597,
8.646938, 1355, 2.998329,
9.102041, 1355, 3.040532,
9.557143, 1355, 3.079427,
10.01225, 1355, 3.11523,
10.46735, 1355, 3.14815,
10.92245, 1355, 3.178389,
11.37755, 1355, 3.20614,
11.83265, 1355, 3.231588,
12.28776, 1355, 3.254905,
12.74286, 1355, 3.276255,
13.19796, 1355, 3.295792,
13.65306, 1355, 3.313661,
14.10816, 1355, 3.329994,
14.56326, 1355, 3.344918,
15.01837, 1355, 3.358547,
15.47347, 1355, 3.37099,
15.92857, 1355, 3.382345,
16.38367, 1355, 3.392705,
16.83878, 1355, 3.402154,
17.29388, 1355, 3.410769,
17.74898, 1355, 3.418623,
18.20408, 1355, 3.425781,
18.65918, 1355, 3.432303,
19.11429, 1355, 3.438245,
19.56939, 1355, 3.443658,
20.02449, 1355, 3.448588,
20.47959, 1355, 3.453077,
20.93469, 1355, 3.457164,
21.3898, 1355, 3.460886,
21.8449, 1355, 3.464273,
22.3, 1355, 3.467357
]);
var buf92 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf92);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc92 = gl.getUniformLocation(prog92,"mvMatrix");
var prMatLoc92 = gl.getUniformLocation(prog92,"prMatrix");
// ****** linestrip object 93 ******
var prog93  = gl.createProgram();
gl.attachShader(prog93, getShader( gl, "unnamed_chunk_4vshader93" ));
gl.attachShader(prog93, getShader( gl, "unnamed_chunk_4fshader93" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog93, 0, "aPos");
gl.bindAttribLocation(prog93, 1, "aCol");
gl.linkProgram(prog93);
var v=new Float32Array([
0, 1355, 1.37,
0.455102, 1355, 1.505563,
0.9102041, 1355, 1.640754,
1.365306, 1355, 1.7745,
1.820408, 1355, 1.905858,
2.27551, 1355, 2.034016,
2.730612, 1355, 2.1583,
3.185714, 1355, 2.278164,
3.640816, 1355, 2.393187,
4.095918, 1355, 2.503058,
4.551021, 1355, 2.607574,
5.006123, 1355, 2.706616,
5.461225, 1355, 2.800148,
5.916327, 1355, 2.888196,
6.371428, 1355, 2.970846,
6.82653, 1355, 3.048224,
7.281632, 1355, 3.120493,
7.736735, 1355, 3.187845,
8.191836, 1355, 3.250489,
8.646938, 1355, 3.308649,
9.102041, 1355, 3.362557,
9.557143, 1355, 3.412448,
10.01225, 1355, 3.45856,
10.46735, 1355, 3.501125,
10.92245, 1355, 3.540371,
11.37755, 1355, 3.576519,
11.83265, 1355, 3.609783,
12.28776, 1355, 3.640367,
12.74286, 1355, 3.668464,
13.19796, 1355, 3.694258,
13.65306, 1355, 3.717922,
14.10816, 1355, 3.73962,
14.56326, 1355, 3.759503,
15.01837, 1355, 3.777716,
15.47347, 1355, 3.79439,
15.92857, 1355, 3.809649,
16.38367, 1355, 3.823609,
16.83878, 1355, 3.836375,
17.29388, 1355, 3.848047,
17.74898, 1355, 3.858714,
18.20408, 1355, 3.86846,
18.65918, 1355, 3.877364,
19.11429, 1355, 3.885496,
19.56939, 1355, 3.892922,
20.02449, 1355, 3.899702,
20.47959, 1355, 3.90589,
20.93469, 1355, 3.911539,
21.3898, 1355, 3.916693,
21.8449, 1355, 3.921397,
22.3, 1355, 3.925688
]);
var buf93 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf93);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc93 = gl.getUniformLocation(prog93,"mvMatrix");
var prMatLoc93 = gl.getUniformLocation(prog93,"prMatrix");
// ****** linestrip object 94 ******
var prog94  = gl.createProgram();
gl.attachShader(prog94, getShader( gl, "unnamed_chunk_4vshader94" ));
gl.attachShader(prog94, getShader( gl, "unnamed_chunk_4fshader94" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog94, 0, "aPos");
gl.bindAttribLocation(prog94, 1, "aCol");
gl.linkProgram(prog94);
var v=new Float32Array([
0, 1360, 1.37,
0.455102, 1360, 1.37632,
0.9102041, 1360, 1.382039,
1.365306, 1360, 1.387213,
1.820408, 1360, 1.391891,
2.27551, 1360, 1.396119,
2.730612, 1360, 1.399941,
3.185714, 1360, 1.403393,
3.640816, 1360, 1.40651,
4.095918, 1360, 1.409325,
4.551021, 1360, 1.411867,
5.006123, 1360, 1.41416,
5.461225, 1360, 1.41623,
5.916327, 1360, 1.418098,
6.371428, 1360, 1.419783,
6.82653, 1360, 1.421303,
7.281632, 1360, 1.422674,
7.736735, 1360, 1.42391,
8.191836, 1360, 1.425025,
8.646938, 1360, 1.42603,
9.102041, 1360, 1.426937,
9.557143, 1360, 1.427754,
10.01225, 1360, 1.428491,
10.46735, 1360, 1.429155,
10.92245, 1360, 1.429754,
11.37755, 1360, 1.430293,
11.83265, 1360, 1.43078,
12.28776, 1360, 1.431218,
12.74286, 1360, 1.431613,
13.19796, 1360, 1.431969,
13.65306, 1360, 1.43229,
14.10816, 1360, 1.43258,
14.56326, 1360, 1.43284,
15.01837, 1360, 1.433075,
15.47347, 1360, 1.433287,
15.92857, 1360, 1.433478,
16.38367, 1360, 1.43365,
16.83878, 1360, 1.433805,
17.29388, 1360, 1.433944,
17.74898, 1360, 1.43407,
18.20408, 1360, 1.434183,
18.65918, 1360, 1.434286,
19.11429, 1360, 1.434378,
19.56939, 1360, 1.434461,
20.02449, 1360, 1.434535,
20.47959, 1360, 1.434603,
20.93469, 1360, 1.434663,
21.3898, 1360, 1.434718,
21.8449, 1360, 1.434767,
22.3, 1360, 1.434812
]);
var buf94 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf94);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc94 = gl.getUniformLocation(prog94,"mvMatrix");
var prMatLoc94 = gl.getUniformLocation(prog94,"prMatrix");
// ****** linestrip object 95 ******
var prog95  = gl.createProgram();
gl.attachShader(prog95, getShader( gl, "unnamed_chunk_4vshader95" ));
gl.attachShader(prog95, getShader( gl, "unnamed_chunk_4fshader95" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog95, 0, "aPos");
gl.bindAttribLocation(prog95, 1, "aCol");
gl.linkProgram(prog95);
var v=new Float32Array([
0, 1365, 1.37,
0.455102, 1365, 1.537964,
0.9102041, 1365, 1.710241,
1.365306, 1365, 1.885344,
1.820408, 1365, 2.061843,
2.27551, 1365, 2.238395,
2.730612, 1365, 2.413763,
3.185714, 1365, 2.586836,
3.640816, 1365, 2.756634,
4.095918, 1365, 2.922318,
4.551021, 1365, 3.083182,
5.006123, 1365, 3.238652,
5.461225, 1365, 3.388279,
5.916327, 1365, 3.531726,
6.371428, 1365, 3.668762,
6.82653, 1365, 3.799248,
7.281632, 1365, 3.923126,
7.736735, 1365, 4.040408,
8.191836, 1365, 4.151167,
8.646938, 1365, 4.255523,
9.102041, 1365, 4.353638,
9.557143, 1365, 4.445705,
10.01225, 1365, 4.531943,
10.46735, 1365, 4.612588,
10.92245, 1365, 4.687889,
11.37755, 1365, 4.758102,
11.83265, 1365, 4.823489,
12.28776, 1365, 4.88431,
12.74286, 1365, 4.940824,
13.19796, 1365, 4.993282,
13.65306, 1365, 5.041934,
14.10816, 1365, 5.087017,
14.56326, 1365, 5.128761,
15.01837, 1365, 5.167387,
15.47347, 1365, 5.203104,
15.92857, 1365, 5.236113,
16.38367, 1365, 5.266602,
16.83878, 1365, 5.294749,
17.29388, 1365, 5.320723,
17.74898, 1365, 5.344681,
18.20408, 1365, 5.366771,
18.65918, 1365, 5.387132,
19.11429, 1365, 5.405892,
19.56939, 1365, 5.423174,
20.02449, 1365, 5.439088,
20.47959, 1365, 5.45374,
20.93469, 1365, 5.467226,
21.3898, 1365, 5.479636,
21.8449, 1365, 5.491054,
22.3, 1365, 5.501558
]);
var buf95 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf95);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc95 = gl.getUniformLocation(prog95,"mvMatrix");
var prMatLoc95 = gl.getUniformLocation(prog95,"prMatrix");
// ****** linestrip object 96 ******
var prog96  = gl.createProgram();
gl.attachShader(prog96, getShader( gl, "unnamed_chunk_4vshader96" ));
gl.attachShader(prog96, getShader( gl, "unnamed_chunk_4fshader96" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog96, 0, "aPos");
gl.bindAttribLocation(prog96, 1, "aCol");
gl.linkProgram(prog96);
var v=new Float32Array([
0, 1400, 1.37,
0.455102, 1400, 1.543674,
0.9102041, 1400, 1.722839,
1.365306, 1400, 1.905985,
1.820408, 1400, 2.091629,
2.27551, 1400, 2.278355,
2.730612, 1400, 2.464834,
3.185714, 1400, 2.649849,
3.640816, 1400, 2.832308,
4.095918, 1400, 3.011248,
4.551021, 1400, 3.185845,
5.006123, 1400, 3.355403,
5.461225, 1400, 3.519359,
5.916327, 1400, 3.677268,
6.371428, 1400, 3.828796,
6.82653, 1400, 3.973713,
7.281632, 1400, 4.111879,
7.736735, 1400, 4.243233,
8.191836, 1400, 4.367783,
8.646938, 1400, 4.485597,
9.102041, 1400, 4.596793,
9.557143, 1400, 4.701527,
10.01225, 1400, 4.799991,
10.46735, 1400, 4.892399,
10.92245, 1400, 4.978987,
11.37755, 1400, 5.060001,
11.83265, 1400, 5.1357,
12.28776, 1400, 5.206343,
12.74286, 1400, 5.272194,
13.19796, 1400, 5.333513,
13.65306, 1400, 5.390557,
14.10816, 1400, 5.443578,
14.56326, 1400, 5.492817,
15.01837, 1400, 5.538512,
15.47347, 1400, 5.580888,
15.92857, 1400, 5.62016,
16.38367, 1400, 5.656535,
16.83878, 1400, 5.690209,
17.29388, 1400, 5.721366,
17.74898, 1400, 5.750182,
18.20408, 1400, 5.776821,
18.65918, 1400, 5.801438,
19.11429, 1400, 5.824179,
19.56939, 1400, 5.84518,
20.02449, 1400, 5.864567,
20.47959, 1400, 5.882462,
20.93469, 1400, 5.898972,
21.3898, 1400, 5.914203,
21.8449, 1400, 5.928251,
22.3, 1400, 5.941205
]);
var buf96 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf96);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc96 = gl.getUniformLocation(prog96,"mvMatrix");
var prMatLoc96 = gl.getUniformLocation(prog96,"prMatrix");
// ****** linestrip object 97 ******
var prog97  = gl.createProgram();
gl.attachShader(prog97, getShader( gl, "unnamed_chunk_4vshader97" ));
gl.attachShader(prog97, getShader( gl, "unnamed_chunk_4fshader97" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog97, 0, "aPos");
gl.bindAttribLocation(prog97, 1, "aCol");
gl.linkProgram(prog97);
var v=new Float32Array([
0, 1189, 1.37,
0.655102, 1189, 1.609683,
1.310204, 1189, 1.863604,
1.965306, 1189, 2.128858,
2.620408, 1189, 2.402436,
3.27551, 1189, 2.681347,
3.930612, 1189, 2.962715,
4.585714, 1189, 3.243855,
5.240816, 1189, 3.522336,
5.895918, 1189, 3.796011,
6.551021, 1189, 4.063037,
7.206122, 1189, 4.321881,
7.861225, 1189, 4.571311,
8.516327, 1189, 4.810378,
9.171429, 1189, 5.038393,
9.82653, 1189, 5.254903,
10.48163, 1189, 5.459658,
11.13673, 1189, 5.652588,
11.79184, 1189, 5.83377,
12.44694, 1189, 6.003404,
13.10204, 1189, 6.16179,
13.75714, 1189, 6.309304,
14.41224, 1189, 6.446381,
15.06735, 1189, 6.573496,
15.72245, 1189, 6.691153,
16.37755, 1189, 6.799869,
17.03265, 1189, 6.900168,
17.68776, 1189, 6.992573,
18.34286, 1189, 7.077595,
18.99796, 1189, 7.155735,
19.65306, 1189, 7.227472,
20.30816, 1189, 7.293269,
20.96326, 1189, 7.353565,
21.61837, 1189, 7.408776,
22.27347, 1189, 7.459295,
22.92857, 1189, 7.505491,
23.58367, 1189, 7.547708,
24.23878, 1189, 7.586267,
24.89388, 1189, 7.62147,
25.54898, 1189, 7.653594,
26.20408, 1189, 7.682895,
26.85918, 1189, 7.709613,
27.51429, 1189, 7.733967,
28.16939, 1189, 7.756159,
28.82449, 1189, 7.776376,
29.47959, 1189, 7.794789,
30.13469, 1189, 7.811555,
30.7898, 1189, 7.826818,
31.4449, 1189, 7.840711,
32.1, 1189, 7.853354
]);
var buf97 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf97);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc97 = gl.getUniformLocation(prog97,"mvMatrix");
var prMatLoc97 = gl.getUniformLocation(prog97,"prMatrix");
// ****** linestrip object 98 ******
var prog98  = gl.createProgram();
gl.attachShader(prog98, getShader( gl, "unnamed_chunk_4vshader98" ));
gl.attachShader(prog98, getShader( gl, "unnamed_chunk_4fshader98" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog98, 0, "aPos");
gl.bindAttribLocation(prog98, 1, "aCol");
gl.linkProgram(prog98);
var v=new Float32Array([
0, 1205, 1.37,
0.655102, 1205, 1.80273,
1.310204, 1205, 2.297776,
1.965306, 1205, 2.847454,
2.620408, 1205, 3.441886,
3.27551, 1205, 4.06988,
3.930612, 1205, 4.719769,
4.585714, 1205, 5.380143,
5.240816, 1205, 6.040422,
5.895918, 1205, 6.691247,
6.551021, 1205, 7.324702,
7.206122, 1205, 7.934406,
7.861225, 1205, 8.515487,
8.516327, 1205, 9.064475,
9.171429, 1205, 9.579156,
9.82653, 1205, 10.05839,
10.48163, 1205, 10.50195,
11.13673, 1205, 10.91029,
11.79184, 1205, 11.28445,
12.44694, 1205, 11.62586,
13.10204, 1205, 11.93625,
13.75714, 1205, 12.21751,
14.41224, 1205, 12.47164,
15.06735, 1205, 12.70069,
15.72245, 1205, 12.90665,
16.37755, 1205, 13.0915,
17.03265, 1205, 13.2571,
17.68776, 1205, 13.40522,
18.34286, 1205, 13.53754,
18.99796, 1205, 13.65559,
19.65306, 1205, 13.76079,
20.30816, 1205, 13.85447,
20.96326, 1205, 13.9378,
21.61837, 1205, 14.01188,
22.27347, 1205, 14.07769,
22.92857, 1205, 14.13613,
23.58367, 1205, 14.18798,
24.23878, 1205, 14.23398,
24.89388, 1205, 14.27476,
25.54898, 1205, 14.31091,
26.20408, 1205, 14.34293,
26.85918, 1205, 14.37131,
27.51429, 1205, 14.39643,
28.16939, 1205, 14.41868,
28.82449, 1205, 14.43837,
29.47959, 1205, 14.4558,
30.13469, 1205, 14.47123,
30.7898, 1205, 14.48488,
31.4449, 1205, 14.49696,
32.1, 1205, 14.50764
]);
var buf98 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf98);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc98 = gl.getUniformLocation(prog98,"mvMatrix");
var prMatLoc98 = gl.getUniformLocation(prog98,"prMatrix");
// ****** linestrip object 99 ******
var prog99  = gl.createProgram();
gl.attachShader(prog99, getShader( gl, "unnamed_chunk_4vshader99" ));
gl.attachShader(prog99, getShader( gl, "unnamed_chunk_4fshader99" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog99, 0, "aPos");
gl.bindAttribLocation(prog99, 1, "aCol");
gl.linkProgram(prog99);
var v=new Float32Array([
0, 1219, 1.37,
0.655102, 1219, 1.512698,
1.310204, 1219, 1.657178,
1.965306, 1219, 1.802364,
2.620408, 1219, 1.94725,
3.27551, 1219, 2.090916,
3.930612, 1219, 2.232534,
4.585714, 1219, 2.371381,
5.240816, 1219, 2.506832,
5.895918, 1219, 2.638365,
6.551021, 1219, 2.765555,
7.206122, 1219, 2.888066,
7.861225, 1219, 3.005648,
8.516327, 1219, 3.118129,
9.171429, 1219, 3.225401,
9.82653, 1219, 3.327422,
10.48163, 1219, 3.424198,
11.13673, 1219, 3.515781,
11.79184, 1219, 3.602261,
12.44694, 1219, 3.683759,
13.10204, 1219, 3.760418,
13.75714, 1219, 3.832405,
14.41224, 1219, 3.899897,
15.06735, 1219, 3.963084,
15.72245, 1219, 4.022162,
16.37755, 1219, 4.07733,
17.03265, 1219, 4.128789,
17.68776, 1219, 4.17674,
18.34286, 1219, 4.221377,
18.99796, 1219, 4.262894,
19.65306, 1219, 4.301477,
20.30816, 1219, 4.337308,
20.96326, 1219, 4.37056,
21.61837, 1219, 4.401398,
22.27347, 1219, 4.429981,
22.92857, 1219, 4.45646,
23.58367, 1219, 4.480979,
24.23878, 1219, 4.503671,
24.89388, 1219, 4.524663,
25.54898, 1219, 4.544077,
26.20408, 1219, 4.562024,
26.85918, 1219, 4.578609,
27.51429, 1219, 4.593932,
28.16939, 1219, 4.608084,
28.82449, 1219, 4.621151,
29.47959, 1219, 4.633215,
30.13469, 1219, 4.644349,
30.7898, 1219, 4.654623,
31.4449, 1219, 4.664103,
32.1, 1219, 4.672846
]);
var buf99 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf99);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc99 = gl.getUniformLocation(prog99,"mvMatrix");
var prMatLoc99 = gl.getUniformLocation(prog99,"prMatrix");
// ****** linestrip object 100 ******
var prog100  = gl.createProgram();
gl.attachShader(prog100, getShader( gl, "unnamed_chunk_4vshader100" ));
gl.attachShader(prog100, getShader( gl, "unnamed_chunk_4fshader100" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog100, 0, "aPos");
gl.bindAttribLocation(prog100, 1, "aCol");
gl.linkProgram(prog100);
var v=new Float32Array([
0, 1231, 1.37,
0.655102, 1231, 1.661901,
1.310204, 1231, 1.978096,
1.965306, 1231, 2.314501,
2.620408, 1231, 2.666645,
3.27551, 1231, 3.029909,
3.930612, 1231, 3.399728,
4.585714, 1231, 3.771764,
5.240816, 1231, 4.142033,
5.895918, 1231, 4.506989,
6.551021, 1231, 4.863581,
7.206122, 1231, 5.209265,
7.861225, 1231, 5.542003,
8.516327, 1231, 5.860234,
9.171429, 1231, 6.162835,
9.82653, 1231, 6.44908,
10.48163, 1231, 6.718581,
11.13673, 1231, 6.971246,
11.79184, 1231, 7.207223,
12.44694, 1231, 7.426855,
13.10204, 1231, 7.63064,
13.75714, 1231, 7.819192,
14.41224, 1231, 7.993209,
15.06735, 1231, 8.153447,
15.72245, 1231, 8.300693,
16.37755, 1231, 8.435748,
17.03265, 1231, 8.559418,
17.68776, 1231, 8.67249,
18.34286, 1231, 8.775732,
18.99796, 1231, 8.869884,
19.65306, 1231, 8.955649,
20.30816, 1231, 9.033699,
20.96326, 1231, 9.104664,
21.61837, 1231, 9.169133,
22.27347, 1231, 9.227659,
22.92857, 1231, 9.280755,
23.58367, 1231, 9.328896,
24.23878, 1231, 9.37252,
24.89388, 1231, 9.412033,
25.54898, 1231, 9.447807,
26.20408, 1231, 9.480182,
26.85918, 1231, 9.509471,
27.51429, 1231, 9.53596,
28.16939, 1231, 9.55991,
28.82449, 1231, 9.581557,
29.47959, 1231, 9.60112,
30.13469, 1231, 9.618795,
30.7898, 1231, 9.634762,
31.4449, 1231, 9.649181,
32.1, 1231, 9.662203
]);
var buf100 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf100);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc100 = gl.getUniformLocation(prog100,"mvMatrix");
var prMatLoc100 = gl.getUniformLocation(prog100,"prMatrix");
// ****** linestrip object 101 ******
var prog101  = gl.createProgram();
gl.attachShader(prog101, getShader( gl, "unnamed_chunk_4vshader101" ));
gl.attachShader(prog101, getShader( gl, "unnamed_chunk_4fshader101" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog101, 0, "aPos");
gl.bindAttribLocation(prog101, 1, "aCol");
gl.linkProgram(prog101);
var v=new Float32Array([
0, 1235, 1.37,
0.655102, 1235, 1.580305,
1.310204, 1235, 1.800201,
1.965306, 1235, 2.027393,
2.620408, 1235, 2.259578,
3.27551, 1235, 2.494515,
3.930612, 1235, 2.730088,
4.585714, 1235, 2.96435,
5.240816, 1235, 3.195554,
5.895918, 1235, 3.422172,
6.551021, 1235, 3.642901,
7.206122, 1235, 3.856664,
7.861225, 1235, 4.062599,
8.516327, 1235, 4.260047,
9.171429, 1235, 4.448534,
9.82653, 1235, 4.627753,
10.48163, 1235, 4.797542,
11.13673, 1235, 4.957865,
11.79184, 1235, 5.108794,
12.44694, 1235, 5.250488,
13.10204, 1235, 5.383179,
13.75714, 1235, 5.507153,
14.41224, 1235, 5.622741,
15.06735, 1235, 5.730304,
15.72245, 1235, 5.830227,
16.37755, 1235, 5.922904,
17.03265, 1235, 6.008735,
17.68776, 1235, 6.088122,
18.34286, 1235, 6.16146,
18.99796, 1235, 6.229136,
19.65306, 1235, 6.291523,
20.30816, 1235, 6.348983,
20.96326, 1235, 6.40186,
21.61837, 1235, 6.450483,
22.27347, 1235, 6.495163,
22.92857, 1235, 6.536194,
23.58367, 1235, 6.573851,
24.23878, 1235, 6.608395,
24.89388, 1235, 6.640067,
25.54898, 1235, 6.669093,
26.20408, 1235, 6.695683,
26.85918, 1235, 6.720034,
27.51429, 1235, 6.742326,
28.16939, 1235, 6.762727,
28.82449, 1235, 6.781392,
29.47959, 1235, 6.798465,
30.13469, 1235, 6.814078,
30.7898, 1235, 6.828352,
31.4449, 1235, 6.841401,
32.1, 1235, 6.853327
]);
var buf101 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf101);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc101 = gl.getUniformLocation(prog101,"mvMatrix");
var prMatLoc101 = gl.getUniformLocation(prog101,"prMatrix");
// ****** linestrip object 102 ******
var prog102  = gl.createProgram();
gl.attachShader(prog102, getShader( gl, "unnamed_chunk_4vshader102" ));
gl.attachShader(prog102, getShader( gl, "unnamed_chunk_4fshader102" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog102, 0, "aPos");
gl.bindAttribLocation(prog102, 1, "aCol");
gl.linkProgram(prog102);
var v=new Float32Array([
0, 1235, 1.37,
0.655102, 1235, 1.766974,
1.310204, 1235, 2.215153,
1.965306, 1235, 2.707811,
2.620408, 1235, 3.236663,
3.27551, 1235, 3.792519,
3.930612, 1235, 4.365909,
4.585714, 1235, 4.947614,
5.240816, 1235, 5.529085,
5.895918, 1235, 6.102726,
6.551021, 1235, 6.662066,
7.206122, 1235, 7.201825,
7.861225, 1235, 7.717906,
8.516327, 1235, 8.207316,
9.171429, 1235, 8.668067,
9.82653, 1235, 9.099036,
10.48163, 1235, 9.499837,
11.13673, 1235, 9.870683,
11.79184, 1235, 10.21226,
12.44694, 1235, 10.5256,
13.10204, 1235, 10.81203,
13.75714, 1235, 11.07301,
14.41224, 1235, 11.31014,
15.06735, 1235, 11.52505,
15.72245, 1235, 11.7194,
16.37755, 1235, 11.8948,
17.03265, 1235, 12.05282,
17.68776, 1235, 12.19496,
18.34286, 1235, 12.32265,
18.99796, 1235, 12.43719,
19.65306, 1235, 12.53985,
20.30816, 1235, 12.63175,
20.96326, 1235, 12.71396,
21.61837, 1235, 12.78745,
22.27347, 1235, 12.85308,
22.92857, 1235, 12.91168,
23.58367, 1235, 12.96395,
24.23878, 1235, 13.01057,
24.89388, 1235, 13.05212,
25.54898, 1235, 13.08915,
26.20408, 1235, 13.12213,
26.85918, 1235, 13.1515,
27.51429, 1235, 13.17765,
28.16939, 1235, 13.20092,
28.82449, 1235, 13.22163,
29.47959, 1235, 13.24005,
30.13469, 1235, 13.25644,
30.7898, 1235, 13.27102,
31.4449, 1235, 13.28398,
32.1, 1235, 13.29551
]);
var buf102 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf102);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc102 = gl.getUniformLocation(prog102,"mvMatrix");
var prMatLoc102 = gl.getUniformLocation(prog102,"prMatrix");
// ****** linestrip object 103 ******
var prog103  = gl.createProgram();
gl.attachShader(prog103, getShader( gl, "unnamed_chunk_4vshader103" ));
gl.attachShader(prog103, getShader( gl, "unnamed_chunk_4fshader103" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog103, 0, "aPos");
gl.bindAttribLocation(prog103, 1, "aCol");
gl.linkProgram(prog103);
var v=new Float32Array([
0, 1239, 1.37,
0.655102, 1239, 1.661901,
1.310204, 1239, 1.978096,
1.965306, 1239, 2.314501,
2.620408, 1239, 2.666645,
3.27551, 1239, 3.029909,
3.930612, 1239, 3.399728,
4.585714, 1239, 3.771764,
5.240816, 1239, 4.142033,
5.895918, 1239, 4.506989,
6.551021, 1239, 4.863581,
7.206122, 1239, 5.209265,
7.861225, 1239, 5.542003,
8.516327, 1239, 5.860234,
9.171429, 1239, 6.162835,
9.82653, 1239, 6.44908,
10.48163, 1239, 6.718581,
11.13673, 1239, 6.971246,
11.79184, 1239, 7.207223,
12.44694, 1239, 7.426855,
13.10204, 1239, 7.63064,
13.75714, 1239, 7.819192,
14.41224, 1239, 7.993209,
15.06735, 1239, 8.153447,
15.72245, 1239, 8.300693,
16.37755, 1239, 8.435748,
17.03265, 1239, 8.559418,
17.68776, 1239, 8.67249,
18.34286, 1239, 8.775732,
18.99796, 1239, 8.869884,
19.65306, 1239, 8.955649,
20.30816, 1239, 9.033699,
20.96326, 1239, 9.104664,
21.61837, 1239, 9.169133,
22.27347, 1239, 9.227659,
22.92857, 1239, 9.280755,
23.58367, 1239, 9.328896,
24.23878, 1239, 9.37252,
24.89388, 1239, 9.412033,
25.54898, 1239, 9.447807,
26.20408, 1239, 9.480182,
26.85918, 1239, 9.509471,
27.51429, 1239, 9.53596,
28.16939, 1239, 9.55991,
28.82449, 1239, 9.581557,
29.47959, 1239, 9.60112,
30.13469, 1239, 9.618795,
30.7898, 1239, 9.634762,
31.4449, 1239, 9.649181,
32.1, 1239, 9.662203
]);
var buf103 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf103);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc103 = gl.getUniformLocation(prog103,"mvMatrix");
var prMatLoc103 = gl.getUniformLocation(prog103,"prMatrix");
// ****** linestrip object 104 ******
var prog104  = gl.createProgram();
gl.attachShader(prog104, getShader( gl, "unnamed_chunk_4vshader104" ));
gl.attachShader(prog104, getShader( gl, "unnamed_chunk_4fshader104" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog104, 0, "aPos");
gl.bindAttribLocation(prog104, 1, "aCol");
gl.linkProgram(prog104);
var v=new Float32Array([
0, 1240, 1.37,
0.655102, 1240, 1.737515,
1.310204, 1240, 2.147815,
1.965306, 1240, 2.594943,
2.620408, 1240, 3.071809,
3.27551, 1240, 3.570694,
3.930612, 1240, 4.083727,
4.585714, 1240, 4.603284,
5.240816, 1240, 5.122302,
5.895918, 1240, 5.634491,
6.551021, 1240, 6.134469,
7.206122, 1240, 6.617806,
7.861225, 1240, 7.081024,
8.516327, 1240, 7.521541,
9.171429, 1240, 7.937588,
9.82653, 1240, 8.328114,
10.48163, 1240, 8.692675,
11.13673, 1240, 9.031334,
11.79184, 1240, 9.34456,
12.44694, 1240, 9.633135,
13.10204, 1240, 9.898075,
13.75714, 1240, 10.14056,
14.41224, 1240, 10.36189,
15.06735, 1240, 10.5634,
15.72245, 1240, 10.74646,
16.37755, 1240, 10.91244,
17.03265, 1240, 11.06267,
17.68776, 1240, 11.19843,
18.34286, 1240, 11.32094,
18.99796, 1240, 11.43136,
19.65306, 1240, 11.53077,
20.30816, 1240, 11.62018,
20.96326, 1240, 11.70052,
21.61837, 1240, 11.77266,
22.27347, 1240, 11.83739,
22.92857, 1240, 11.89544,
23.58367, 1240, 11.94745,
24.23878, 1240, 11.99405,
24.89388, 1240, 12.03577,
25.54898, 1240, 12.07311,
26.20408, 1240, 12.10652,
26.85918, 1240, 12.1364,
27.51429, 1240, 12.16311,
28.16939, 1240, 12.187,
28.82449, 1240, 12.20834,
29.47959, 1240, 12.22741,
30.13469, 1240, 12.24445,
30.7898, 1240, 12.25967,
31.4449, 1240, 12.27326,
32.1, 1240, 12.2854
]);
var buf104 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf104);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc104 = gl.getUniformLocation(prog104,"mvMatrix");
var prMatLoc104 = gl.getUniformLocation(prog104,"prMatrix");
// ****** linestrip object 105 ******
var prog105  = gl.createProgram();
gl.attachShader(prog105, getShader( gl, "unnamed_chunk_4vshader105" ));
gl.attachShader(prog105, getShader( gl, "unnamed_chunk_4fshader105" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog105, 0, "aPos");
gl.bindAttribLocation(prog105, 1, "aCol");
gl.linkProgram(prog105);
var v=new Float32Array([
0, 1245, 1.37,
0.655102, 1245, 1.708305,
1.310204, 1245, 2.081712,
1.965306, 1245, 2.485009,
2.620408, 1245, 2.912189,
3.27551, 1245, 3.356844,
3.930612, 1245, 3.812508,
4.585714, 1245, 4.272962,
5.240816, 1245, 4.732452,
5.895918, 1245, 5.185856,
6.551021, 1245, 5.628768,
7.206122, 1245, 6.057545,
7.861225, 1245, 6.469294,
8.516327, 1245, 6.861839,
9.171429, 1245, 7.233654,
9.82653, 1245, 7.583791,
10.48163, 1245, 7.911803,
11.13673, 1245, 8.217656,
11.79184, 1245, 8.501658,
12.44694, 1245, 8.764385,
13.10204, 1245, 9.006616,
13.75714, 1245, 9.22928,
14.41224, 1245, 9.433406,
15.06735, 1245, 9.620089,
15.72245, 1245, 9.790448,
16.37755, 1245, 9.945613,
17.03265, 1245, 10.08669,
17.68776, 1245, 10.21477,
18.34286, 1245, 10.33087,
18.99796, 1245, 10.436,
19.65306, 1245, 10.53107,
20.30816, 1245, 10.61698,
20.96326, 1245, 10.69452,
21.61837, 1245, 10.76446,
22.27347, 1245, 10.82751,
22.92857, 1245, 10.88429,
23.58367, 1245, 10.93541,
24.23878, 1245, 10.98141,
24.89388, 1245, 11.02277,
25.54898, 1245, 11.05996,
26.20408, 1245, 11.09338,
26.85918, 1245, 11.12339,
27.51429, 1245, 11.15036,
28.16939, 1245, 11.17456,
28.82449, 1245, 11.19629,
29.47959, 1245, 11.21579,
30.13469, 1245, 11.23328,
30.7898, 1245, 11.24898,
31.4449, 1245, 11.26306,
32.1, 1245, 11.27568
]);
var buf105 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf105);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc105 = gl.getUniformLocation(prog105,"mvMatrix");
var prMatLoc105 = gl.getUniformLocation(prog105,"prMatrix");
// ****** linestrip object 106 ******
var prog106  = gl.createProgram();
gl.attachShader(prog106, getShader( gl, "unnamed_chunk_4vshader106" ));
gl.attachShader(prog106, getShader( gl, "unnamed_chunk_4fshader106" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog106, 0, "aPos");
gl.bindAttribLocation(prog106, 1, "aCol");
gl.linkProgram(prog106);
var v=new Float32Array([
0, 1249, 1.37,
0.655102, 1249, 1.696675,
1.310204, 1249, 2.055582,
1.965306, 1249, 2.441796,
2.620408, 1249, 2.849719,
3.27551, 1249, 3.27342,
3.930612, 1249, 3.706951,
4.585714, 1249, 4.144601,
5.240816, 1249, 4.581096,
5.895918, 1249, 5.011738,
6.551021, 1249, 5.432487,
7.206122, 1249, 5.839993,
7.861225, 1249, 6.231586,
8.516327, 1249, 6.605247,
9.171429, 1249, 6.959553,
9.82653, 1249, 7.293607,
10.48163, 1249, 7.606966,
11.13673, 1249, 7.899576,
11.79184, 1249, 8.171692,
12.44694, 1249, 8.423821,
13.10204, 1249, 8.656662,
13.75714, 1249, 8.871056,
14.41224, 1249, 9.067938,
15.06735, 1249, 9.24831,
15.72245, 1249, 9.413203,
16.37755, 1249, 9.563658,
17.03265, 1249, 9.7007,
17.68776, 1249, 9.825335,
18.34286, 1249, 9.938526,
18.99796, 1249, 10.0412,
19.65306, 1249, 10.13423,
20.30816, 1249, 10.21843,
20.96326, 1249, 10.29458,
21.61837, 1249, 10.36339,
22.27347, 1249, 10.42552,
22.92857, 1249, 10.48158,
23.58367, 1249, 10.53214,
24.23878, 1249, 10.57771,
24.89388, 1249, 10.61877,
25.54898, 1249, 10.65575,
26.20408, 1249, 10.68904,
26.85918, 1249, 10.719,
27.51429, 1249, 10.74594,
28.16939, 1249, 10.77018,
28.82449, 1249, 10.79198,
29.47959, 1249, 10.81157,
30.13469, 1249, 10.82919,
30.7898, 1249, 10.84501,
31.4449, 1249, 10.85923,
32.1, 1249, 10.87201
]);
var buf106 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf106);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc106 = gl.getUniformLocation(prog106,"mvMatrix");
var prMatLoc106 = gl.getUniformLocation(prog106,"prMatrix");
// ****** linestrip object 107 ******
var prog107  = gl.createProgram();
gl.attachShader(prog107, getShader( gl, "unnamed_chunk_4vshader107" ));
gl.attachShader(prog107, getShader( gl, "unnamed_chunk_4fshader107" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog107, 0, "aPos");
gl.bindAttribLocation(prog107, 1, "aCol");
gl.linkProgram(prog107);
var v=new Float32Array([
0, 1261, 1.37,
0.655102, 1261, 1.702487,
1.310204, 1261, 2.068626,
1.965306, 1261, 2.463351,
2.620408, 1261, 2.880859,
3.27551, 1261, 3.314985,
3.930612, 1261, 3.759526,
4.585714, 1261, 4.208519,
5.240816, 1261, 4.656453,
5.895918, 1261, 5.098422,
6.551021, 1261, 5.530205,
7.206122, 1261, 5.948305,
7.861225, 1261, 6.349944,
8.516327, 1261, 6.733024,
9.171429, 1261, 7.096069,
9.82653, 1261, 7.438158,
10.48163, 1261, 7.758844,
11.13673, 1261, 8.058083,
11.79184, 1261, 8.336154,
12.44694, 1261, 8.593598,
13.10204, 1261, 8.831154,
13.75714, 1261, 9.049706,
14.41224, 1261, 9.250236,
15.06735, 1261, 9.433788,
15.72245, 1261, 9.601442,
16.37755, 1261, 9.754279,
17.03265, 1261, 9.893367,
17.68776, 1261, 10.01975,
18.34286, 1261, 10.13442,
18.99796, 1261, 10.23834,
19.65306, 1261, 10.33242,
20.30816, 1261, 10.41749,
20.96326, 1261, 10.49436,
21.61837, 1261, 10.56375,
22.27347, 1261, 10.62636,
22.92857, 1261, 10.6828,
23.58367, 1261, 10.73365,
24.23878, 1261, 10.77945,
24.89388, 1261, 10.82068,
25.54898, 1261, 10.85777,
26.20408, 1261, 10.89113,
26.85918, 1261, 10.92113,
27.51429, 1261, 10.94809,
28.16939, 1261, 10.97232,
28.82449, 1261, 10.99409,
29.47959, 1261, 11.01364,
30.13469, 1261, 11.0312,
30.7898, 1261, 11.04697,
31.4449, 1261, 11.06112,
32.1, 1261, 11.07382
]);
var buf107 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf107);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc107 = gl.getUniformLocation(prog107,"mvMatrix");
var prMatLoc107 = gl.getUniformLocation(prog107,"prMatrix");
// ****** linestrip object 108 ******
var prog108  = gl.createProgram();
gl.attachShader(prog108, getShader( gl, "unnamed_chunk_4vshader108" ));
gl.attachShader(prog108, getShader( gl, "unnamed_chunk_4fshader108" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog108, 0, "aPos");
gl.bindAttribLocation(prog108, 1, "aCol");
gl.linkProgram(prog108);
var v=new Float32Array([
0, 1265, 1.37,
0.655102, 1265, 1.725804,
1.310204, 1265, 2.121234,
1.965306, 1265, 2.550632,
2.620408, 1265, 3.007354,
3.27551, 1265, 3.484225,
3.930612, 1265, 3.973957,
4.585714, 1265, 4.469512,
5.240816, 1265, 4.964368,
5.895918, 1265, 5.452721,
6.551021, 1265, 5.929591,
7.206122, 1265, 6.390872,
7.861225, 1265, 6.833326,
8.516327, 1265, 7.254531,
9.171429, 1265, 7.652816,
9.82653, 1265, 8.027165,
10.48163, 1265, 8.377131,
11.13673, 1265, 8.702729,
11.79184, 1265, 9.004358,
12.44694, 1265, 9.282713,
13.10204, 1265, 9.538707,
13.75714, 1265, 9.773417,
14.41224, 1265, 9.988024,
15.06735, 1265, 10.18377,
15.72245, 1265, 10.36192,
16.37755, 1265, 10.52374,
17.03265, 1265, 10.67047,
17.68776, 1265, 10.80331,
18.34286, 1265, 10.92341,
18.99796, 1265, 11.03186,
19.65306, 1265, 11.12967,
20.30816, 1265, 11.2178,
20.96326, 1265, 11.29714,
21.61837, 1265, 11.36851,
22.27347, 1265, 11.43266,
22.92857, 1265, 11.49029,
23.58367, 1265, 11.54203,
24.23878, 1265, 11.58846,
24.89388, 1265, 11.63011,
25.54898, 1265, 11.66744,
26.20408, 1265, 11.70091,
26.85918, 1265, 11.73089,
27.51429, 1265, 11.75775,
28.16939, 1265, 11.7818,
28.82449, 1265, 11.80333,
29.47959, 1265, 11.82261,
30.13469, 1265, 11.83985,
30.7898, 1265, 11.85529,
31.4449, 1265, 11.86909,
32.1, 1265, 11.88144
]);
var buf108 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf108);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc108 = gl.getUniformLocation(prog108,"mvMatrix");
var prMatLoc108 = gl.getUniformLocation(prog108,"prMatrix");
// ****** linestrip object 109 ******
var prog109  = gl.createProgram();
gl.attachShader(prog109, getShader( gl, "unnamed_chunk_4vshader109" ));
gl.attachShader(prog109, getShader( gl, "unnamed_chunk_4fshader109" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog109, 0, "aPos");
gl.bindAttribLocation(prog109, 1, "aCol");
gl.linkProgram(prog109);
var v=new Float32Array([
0, 1268, 1.37,
0.655102, 1268, 1.7729,
1.310204, 1268, 2.228781,
1.965306, 1268, 2.730758,
2.620408, 1268, 3.270293,
3.27551, 1268, 3.837882,
3.930612, 1268, 4.42371,
4.585714, 1268, 5.018216,
5.240816, 1268, 5.612529,
5.895918, 1268, 6.198775,
6.551021, 1268, 6.770254,
7.206122, 1268, 7.321508,
7.861225, 1268, 7.848312,
8.516327, 1268, 8.347592,
9.171429, 1268, 8.817319,
9.82653, 1268, 9.256363,
10.48163, 1268, 9.664354,
11.13673, 1268, 10.04154,
11.79184, 1268, 10.38866,
12.44694, 1268, 10.70682,
13.10204, 1268, 10.99738,
13.75714, 1268, 11.26189,
14.41224, 1268, 11.50201,
15.06735, 1268, 11.71943,
15.72245, 1268, 11.91586,
16.37755, 1268, 12.09297,
17.03265, 1268, 12.25239,
17.68776, 1268, 12.39565,
18.34286, 1268, 12.52422,
18.99796, 1268, 12.63946,
19.65306, 1268, 12.74264,
20.30816, 1268, 12.83493,
20.96326, 1268, 12.91741,
21.61837, 1268, 12.99107,
22.27347, 1268, 13.0568,
22.92857, 1268, 13.11542,
23.58367, 1268, 13.16768,
24.23878, 1268, 13.21424,
24.89388, 1268, 13.2557,
25.54898, 1268, 13.29262,
26.20408, 1268, 13.32547,
26.85918, 1268, 13.3547,
27.51429, 1268, 13.3807,
28.16939, 1268, 13.40382,
28.82449, 1268, 13.42438,
29.47959, 1268, 13.44265,
30.13469, 1268, 13.45889,
30.7898, 1268, 13.47333,
31.4449, 1268, 13.48615,
32.1, 1268, 13.49754
]);
var buf109 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf109);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc109 = gl.getUniformLocation(prog109,"mvMatrix");
var prMatLoc109 = gl.getUniformLocation(prog109,"prMatrix");
// ****** linestrip object 110 ******
var prog110  = gl.createProgram();
gl.attachShader(prog110, getShader( gl, "unnamed_chunk_4vshader110" ));
gl.attachShader(prog110, getShader( gl, "unnamed_chunk_4fshader110" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog110, 0, "aPos");
gl.bindAttribLocation(prog110, 1, "aCol");
gl.linkProgram(prog110);
var v=new Float32Array([
0, 1269, 1.37,
0.655102, 1269, 1.644534,
1.310204, 1269, 1.939767,
1.965306, 1269, 2.252017,
2.620408, 1269, 2.577332,
3.27551, 1269, 2.911677,
3.930612, 1269, 3.251099,
4.585714, 1269, 3.591862,
5.240816, 1269, 3.930546,
5.895918, 1269, 4.264116,
6.551021, 1269, 4.589959,
7.206122, 1269, 4.905895,
7.861225, 1269, 5.210173,
8.516327, 1269, 5.501447,
9.171429, 1269, 5.778745,
9.82653, 1269, 6.04143,
10.48163, 1269, 6.289157,
11.13673, 1269, 6.52183,
11.79184, 1269, 6.739564,
12.44694, 1269, 6.942643,
13.10204, 1269, 7.131486,
13.75714, 1269, 7.306615,
14.41224, 1269, 7.468629,
15.06735, 1269, 7.618177,
15.72245, 1269, 7.755943,
16.37755, 1269, 7.882625,
17.03265, 1269, 7.998924,
17.68776, 1269, 8.105534,
18.34286, 1269, 8.203131,
18.99796, 1269, 8.292368,
19.65306, 1269, 8.373873,
20.30816, 1269, 8.448241,
20.96326, 1269, 8.516039,
21.61837, 1269, 8.577795,
22.27347, 1269, 8.634007,
22.92857, 1269, 8.68514,
23.58367, 1269, 8.731624,
24.23878, 1269, 8.773859,
24.89388, 1269, 8.812215,
25.54898, 1269, 8.847033,
26.20408, 1269, 8.878626,
26.85918, 1269, 8.907283,
27.51429, 1269, 8.933269,
28.16939, 1269, 8.956824,
28.82449, 1269, 8.978172,
29.47959, 1269, 8.997515,
30.13469, 1269, 9.015035,
30.7898, 1269, 9.030903,
31.4449, 1269, 9.045272,
32.1, 1269, 9.058281
]);
var buf110 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf110);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc110 = gl.getUniformLocation(prog110,"mvMatrix");
var prMatLoc110 = gl.getUniformLocation(prog110,"prMatrix");
// ****** linestrip object 111 ******
var prog111  = gl.createProgram();
gl.attachShader(prog111, getShader( gl, "unnamed_chunk_4vshader111" ));
gl.attachShader(prog111, getShader( gl, "unnamed_chunk_4fshader111" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog111, 0, "aPos");
gl.bindAttribLocation(prog111, 1, "aCol");
gl.linkProgram(prog111);
var v=new Float32Array([
0, 1271, 1.37,
0.655102, 1271, 1.690869,
1.310204, 1271, 2.042578,
1.965306, 1271, 2.420343,
2.620408, 1271, 2.818765,
3.27551, 1271, 3.232144,
3.930612, 1271, 3.654779,
4.585714, 1271, 4.081203,
5.240816, 1271, 4.506373,
5.895918, 1271, 4.925798,
6.551021, 1271, 5.33561,
7.206122, 1271, 5.732602,
7.861225, 1271, 6.114214,
8.516327, 1271, 6.478507,
9.171429, 1271, 6.824105,
9.82653, 1271, 7.150139,
10.48163, 1271, 7.456175,
11.13673, 1271, 7.742144,
11.79184, 1271, 8.008282,
12.44694, 1271, 8.255064,
13.10204, 1271, 8.48315,
13.75714, 1271, 8.69334,
14.41224, 1271, 8.886527,
15.06735, 1271, 9.063666,
15.72245, 1271, 9.225746,
16.37755, 1271, 9.373764,
17.03265, 1271, 9.508708,
17.68776, 1271, 9.631544,
18.34286, 1271, 9.743204,
18.99796, 1271, 9.844578,
19.65306, 1271, 9.936511,
20.30816, 1271, 10.0198,
20.96326, 1271, 10.09519,
21.61837, 1271, 10.16337,
22.27347, 1271, 10.22499,
22.92857, 1271, 10.28065,
23.58367, 1271, 10.33088,
24.23878, 1271, 10.37621,
24.89388, 1271, 10.41707,
25.54898, 1271, 10.45391,
26.20408, 1271, 10.4871,
26.85918, 1271, 10.517,
27.51429, 1271, 10.54392,
28.16939, 1271, 10.56815,
28.82449, 1271, 10.58996,
29.47959, 1271, 10.60959,
30.13469, 1271, 10.62724,
30.7898, 1271, 10.64312,
31.4449, 1271, 10.65739,
32.1, 1271, 10.67023
]);
var buf111 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf111);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc111 = gl.getUniformLocation(prog111,"mvMatrix");
var prMatLoc111 = gl.getUniformLocation(prog111,"prMatrix");
// ****** linestrip object 112 ******
var prog112  = gl.createProgram();
gl.attachShader(prog112, getShader( gl, "unnamed_chunk_4vshader112" ));
gl.attachShader(prog112, getShader( gl, "unnamed_chunk_4fshader112" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog112, 0, "aPos");
gl.bindAttribLocation(prog112, 1, "aCol");
gl.linkProgram(prog112);
var v=new Float32Array([
0, 1275, 1.37,
0.655102, 1275, 1.702487,
1.310204, 1275, 2.068626,
1.965306, 1275, 2.463351,
2.620408, 1275, 2.880859,
3.27551, 1275, 3.314985,
3.930612, 1275, 3.759526,
4.585714, 1275, 4.208519,
5.240816, 1275, 4.656453,
5.895918, 1275, 5.098422,
6.551021, 1275, 5.530205,
7.206122, 1275, 5.948305,
7.861225, 1275, 6.349944,
8.516327, 1275, 6.733024,
9.171429, 1275, 7.096069,
9.82653, 1275, 7.438158,
10.48163, 1275, 7.758844,
11.13673, 1275, 8.058083,
11.79184, 1275, 8.336154,
12.44694, 1275, 8.593598,
13.10204, 1275, 8.831154,
13.75714, 1275, 9.049706,
14.41224, 1275, 9.250236,
15.06735, 1275, 9.433788,
15.72245, 1275, 9.601442,
16.37755, 1275, 9.754279,
17.03265, 1275, 9.893367,
17.68776, 1275, 10.01975,
18.34286, 1275, 10.13442,
18.99796, 1275, 10.23834,
19.65306, 1275, 10.33242,
20.30816, 1275, 10.41749,
20.96326, 1275, 10.49436,
21.61837, 1275, 10.56375,
22.27347, 1275, 10.62636,
22.92857, 1275, 10.6828,
23.58367, 1275, 10.73365,
24.23878, 1275, 10.77945,
24.89388, 1275, 10.82068,
25.54898, 1275, 10.85777,
26.20408, 1275, 10.89113,
26.85918, 1275, 10.92113,
27.51429, 1275, 10.94809,
28.16939, 1275, 10.97232,
28.82449, 1275, 10.99409,
29.47959, 1275, 11.01364,
30.13469, 1275, 11.0312,
30.7898, 1275, 11.04697,
31.4449, 1275, 11.06112,
32.1, 1275, 11.07382
]);
var buf112 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf112);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc112 = gl.getUniformLocation(prog112,"mvMatrix");
var prMatLoc112 = gl.getUniformLocation(prog112,"prMatrix");
// ****** linestrip object 113 ******
var prog113  = gl.createProgram();
gl.attachShader(prog113, getShader( gl, "unnamed_chunk_4vshader113" ));
gl.attachShader(prog113, getShader( gl, "unnamed_chunk_4fshader113" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog113, 0, "aPos");
gl.bindAttribLocation(prog113, 1, "aCol");
gl.linkProgram(prog113);
var v=new Float32Array([
0, 1279, 1.37,
0.655102, 1279, 1.71413,
1.310204, 1279, 2.094841,
1.965306, 1279, 2.506773,
2.620408, 1279, 2.943713,
3.27551, 1279, 3.399,
3.930612, 1279, 3.865904,
4.585714, 1279, 4.337938,
5.240816, 1279, 4.809101,
5.895918, 1279, 5.274046,
6.551021, 1279, 5.728183,
7.206122, 1279, 6.167716,
7.861225, 1279, 6.589639,
8.516327, 1279, 6.991694,
9.171429, 1279, 7.372306,
9.82653, 1279, 7.730505,
10.48163, 1279, 8.065841,
11.13673, 1279, 8.378293,
11.79184, 1279, 8.6682,
12.44694, 1279, 8.936173,
13.10204, 1279, 9.183036,
13.75714, 1279, 9.409764,
14.41224, 1279, 9.617436,
15.06735, 1279, 9.807194,
15.72245, 1279, 9.980206,
16.37755, 1279, 10.13764,
17.03265, 1279, 10.28066,
17.68776, 1279, 10.41038,
18.34286, 1279, 10.52787,
18.99796, 1279, 10.63414,
19.65306, 1279, 10.73018,
20.30816, 1279, 10.81687,
20.96326, 1279, 10.89505,
21.61837, 1279, 10.9655,
22.27347, 1279, 11.02895,
22.92857, 1279, 11.08605,
23.58367, 1279, 11.1374,
24.23878, 1279, 11.18357,
24.89388, 1279, 11.22505,
25.54898, 1279, 11.26231,
26.20408, 1279, 11.29576,
26.85918, 1279, 11.32578,
27.51429, 1279, 11.35272,
28.16939, 1279, 11.37689,
28.82449, 1279, 11.39857,
29.47959, 1279, 11.418,
30.13469, 1279, 11.43542,
30.7898, 1279, 11.45104,
31.4449, 1279, 11.46503,
32.1, 1279, 11.47757
]);
var buf113 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf113);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc113 = gl.getUniformLocation(prog113,"mvMatrix");
var prMatLoc113 = gl.getUniformLocation(prog113,"prMatrix");
// ****** linestrip object 114 ******
var prog114  = gl.createProgram();
gl.attachShader(prog114, getShader( gl, "unnamed_chunk_4vshader114" ));
gl.attachShader(prog114, getShader( gl, "unnamed_chunk_4fshader114" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog114, 0, "aPos");
gl.bindAttribLocation(prog114, 1, "aCol");
gl.linkProgram(prog114);
var v=new Float32Array([
0, 1295, 1.37,
0.655102, 1295, 1.661901,
1.310204, 1295, 1.978096,
1.965306, 1295, 2.314501,
2.620408, 1295, 2.666645,
3.27551, 1295, 3.029909,
3.930612, 1295, 3.399728,
4.585714, 1295, 3.771764,
5.240816, 1295, 4.142033,
5.895918, 1295, 4.506989,
6.551021, 1295, 4.863581,
7.206122, 1295, 5.209265,
7.861225, 1295, 5.542003,
8.516327, 1295, 5.860234,
9.171429, 1295, 6.162835,
9.82653, 1295, 6.44908,
10.48163, 1295, 6.718581,
11.13673, 1295, 6.971246,
11.79184, 1295, 7.207223,
12.44694, 1295, 7.426855,
13.10204, 1295, 7.63064,
13.75714, 1295, 7.819192,
14.41224, 1295, 7.993209,
15.06735, 1295, 8.153447,
15.72245, 1295, 8.300693,
16.37755, 1295, 8.435748,
17.03265, 1295, 8.559418,
17.68776, 1295, 8.67249,
18.34286, 1295, 8.775732,
18.99796, 1295, 8.869884,
19.65306, 1295, 8.955649,
20.30816, 1295, 9.033699,
20.96326, 1295, 9.104664,
21.61837, 1295, 9.169133,
22.27347, 1295, 9.227659,
22.92857, 1295, 9.280755,
23.58367, 1295, 9.328896,
24.23878, 1295, 9.37252,
24.89388, 1295, 9.412033,
25.54898, 1295, 9.447807,
26.20408, 1295, 9.480182,
26.85918, 1295, 9.509471,
27.51429, 1295, 9.53596,
28.16939, 1295, 9.55991,
28.82449, 1295, 9.581557,
29.47959, 1295, 9.60112,
30.13469, 1295, 9.618795,
30.7898, 1295, 9.634762,
31.4449, 1295, 9.649181,
32.1, 1295, 9.662203
]);
var buf114 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf114);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc114 = gl.getUniformLocation(prog114,"mvMatrix");
var prMatLoc114 = gl.getUniformLocation(prog114,"prMatrix");
// ****** linestrip object 115 ******
var prog115  = gl.createProgram();
gl.attachShader(prog115, getShader( gl, "unnamed_chunk_4vshader115" ));
gl.attachShader(prog115, getShader( gl, "unnamed_chunk_4fshader115" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog115, 0, "aPos");
gl.bindAttribLocation(prog115, 1, "aCol");
gl.linkProgram(prog115);
var v=new Float32Array([
0, 1295, 1.37,
0.655102, 1295, 1.755156,
1.310204, 1295, 2.18806,
1.965306, 1295, 2.662296,
2.620408, 1295, 3.170069,
3.27551, 1295, 3.702801,
3.930612, 1295, 4.251683,
4.585714, 1295, 4.808161,
5.240816, 1295, 5.364299,
5.895918, 1295, 5.913042,
6.551021, 1295, 6.448367,
7.206122, 1295, 6.965344,
7.861225, 1295, 7.460125,
8.516327, 1295, 7.929882,
9.171429, 1295, 8.372709,
9.82653, 1295, 8.787509,
10.48163, 1295, 9.173867,
11.13673, 1295, 9.531927,
11.79184, 1295, 9.86228,
12.44694, 1295, 10.16586,
13.10204, 1295, 10.44385,
13.75714, 1295, 10.6976,
14.41224, 1295, 10.92858,
15.06735, 1295, 11.13831,
15.72245, 1295, 11.32831,
16.37755, 1295, 11.50012,
17.03265, 1295, 11.65518,
17.68776, 1295, 11.79493,
18.34286, 1295, 11.92068,
18.99796, 1295, 12.03372,
19.65306, 1295, 12.1352,
20.30816, 1295, 12.22622,
20.96326, 1295, 12.3078,
21.61837, 1295, 12.38084,
22.27347, 1295, 12.4462,
22.92857, 1295, 12.50465,
23.58367, 1295, 12.5569,
24.23878, 1295, 12.60357,
24.89388, 1295, 12.64525,
25.54898, 1295, 12.68245,
26.20408, 1295, 12.71565,
26.85918, 1295, 12.74526,
27.51429, 1295, 12.77167,
28.16939, 1295, 12.79522,
28.82449, 1295, 12.81621,
29.47959, 1295, 12.83491,
30.13469, 1295, 12.85158,
30.7898, 1295, 12.86643,
31.4449, 1295, 12.87966,
32.1, 1295, 12.89145
]);
var buf115 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf115);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc115 = gl.getUniformLocation(prog115,"mvMatrix");
var prMatLoc115 = gl.getUniformLocation(prog115,"prMatrix");
// ****** linestrip object 116 ******
var prog116  = gl.createProgram();
gl.attachShader(prog116, getShader( gl, "unnamed_chunk_4vshader116" ));
gl.attachShader(prog116, getShader( gl, "unnamed_chunk_4fshader116" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog116, 0, "aPos");
gl.bindAttribLocation(prog116, 1, "aCol");
gl.linkProgram(prog116);
var v=new Float32Array([
0, 1299, 1.37,
0.655102, 1299, 1.627141,
1.310204, 1299, 1.901629,
1.965306, 1299, 2.190177,
2.620408, 1299, 2.489319,
3.27551, 1299, 2.795561,
3.930612, 1299, 3.105512,
4.585714, 1299, 3.415987,
5.240816, 1299, 3.724083,
5.895918, 1299, 4.02723,
6.551021, 1299, 4.323217,
7.206122, 1299, 4.610202,
7.861225, 1299, 4.886703,
8.516327, 1299, 5.151577,
9.171429, 1299, 5.404,
9.82653, 1299, 5.643424,
10.48163, 1299, 5.86955,
11.13673, 1299, 6.082293,
11.79184, 1299, 6.281743,
12.44694, 1299, 6.468137,
13.10204, 1299, 6.641829,
13.75714, 1299, 6.803262,
14.41224, 1299, 6.952946,
15.06735, 1299, 7.091439,
15.72245, 1299, 7.21933,
16.37755, 1299, 7.337221,
17.03265, 1299, 7.445721,
17.68776, 1299, 7.545434,
18.34286, 1299, 7.636952,
18.99796, 1299, 7.720848,
19.65306, 1299, 7.797674,
20.30816, 1299, 7.867957,
20.96326, 1299, 7.932198,
21.61837, 1299, 7.990869,
22.27347, 1299, 8.044414,
22.92857, 1299, 8.093248,
23.58367, 1299, 8.137761,
24.23878, 1299, 8.178311,
24.89388, 1299, 8.215235,
25.54898, 1299, 8.24884,
26.20408, 1299, 8.279413,
26.85918, 1299, 8.307219,
27.51429, 1299, 8.332498,
28.16939, 1299, 8.355473,
28.82449, 1299, 8.376348,
29.47959, 1299, 8.395312,
30.13469, 1299, 8.412535,
30.7898, 1299, 8.428174,
31.4449, 1299, 8.442371,
32.1, 1299, 8.455258
]);
var buf116 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf116);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc116 = gl.getUniformLocation(prog116,"mvMatrix");
var prMatLoc116 = gl.getUniformLocation(prog116,"prMatrix");
// ****** linestrip object 117 ******
var prog117  = gl.createProgram();
gl.attachShader(prog117, getShader( gl, "unnamed_chunk_4vshader117" ));
gl.attachShader(prog117, getShader( gl, "unnamed_chunk_4fshader117" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog117, 0, "aPos");
gl.bindAttribLocation(prog117, 1, "aCol");
gl.linkProgram(prog117);
var v=new Float32Array([
0, 1302, 1.37,
0.655102, 1302, 1.574366,
1.310204, 1302, 1.787473,
1.965306, 1302, 2.007147,
2.620408, 1302, 2.231213,
3.27551, 1302, 2.457572,
3.930612, 1302, 2.684245,
4.585714, 1302, 2.909418,
5.240816, 1302, 3.131467,
5.895918, 1302, 3.348975,
6.551021, 1302, 3.560737,
7.206122, 1302, 3.765757,
7.861225, 1302, 3.963241,
8.516327, 1302, 4.152583,
9.171429, 1302, 4.333349,
9.82653, 1302, 4.50526,
10.48163, 1302, 4.66817,
11.13673, 1302, 4.822053,
11.79184, 1302, 4.966981,
12.44694, 1302, 5.103106,
13.10204, 1302, 5.23065,
13.75714, 1302, 5.349884,
14.41224, 1302, 5.461122,
15.06735, 1302, 5.564705,
15.72245, 1302, 5.660996,
16.37755, 1302, 5.750368,
17.03265, 1302, 5.8332,
17.68776, 1302, 5.90987,
18.34286, 1302, 5.980753,
18.99796, 1302, 6.046214,
19.65306, 1302, 6.106608,
20.30816, 1302, 6.162277,
20.96326, 1302, 6.213548,
21.61837, 1302, 6.260733,
22.27347, 1302, 6.304128,
22.92857, 1302, 6.344011,
23.58367, 1302, 6.380647,
24.23878, 1302, 6.414282,
24.89388, 1302, 6.445147,
25.54898, 1302, 6.473457,
26.20408, 1302, 6.499414,
26.85918, 1302, 6.523205,
27.51429, 1302, 6.545002,
28.16939, 1302, 6.564969,
28.82449, 1302, 6.583251,
29.47959, 1302, 6.599989,
30.13469, 1302, 6.615308,
30.7898, 1302, 6.629326,
31.4449, 1302, 6.642151,
32.1, 1302, 6.653883
]);
var buf117 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf117);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc117 = gl.getUniformLocation(prog117,"mvMatrix");
var prMatLoc117 = gl.getUniformLocation(prog117,"prMatrix");
// ****** linestrip object 118 ******
var prog118  = gl.createProgram();
gl.attachShader(prog118, getShader( gl, "unnamed_chunk_4vshader118" ));
gl.attachShader(prog118, getShader( gl, "unnamed_chunk_4fshader118" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog118, 0, "aPos");
gl.bindAttribLocation(prog118, 1, "aCol");
gl.linkProgram(prog118);
var v=new Float32Array([
0, 1305, 1.37,
0.655102, 1305, 1.685069,
1.310204, 1305, 2.029612,
1.965306, 1305, 2.398989,
2.620408, 1305, 2.787993,
3.27551, 1305, 3.191151,
3.930612, 1305, 3.603002,
4.585714, 1305, 4.018318,
5.240816, 1305, 4.43228,
5.895918, 1305, 4.840594,
6.551021, 1305, 5.239567,
7.206122, 1305, 5.626128,
7.861225, 1305, 5.997827,
8.516327, 1305, 6.3528,
9.171429, 1305, 6.689724,
9.82653, 1305, 7.007757,
10.48163, 1305, 7.306471,
11.13673, 1305, 7.585791,
11.79184, 1305, 7.84593,
12.44694, 1305, 8.087335,
13.10204, 1305, 8.31063,
13.75714, 1305, 8.516572,
14.41224, 1305, 8.706016,
15.06735, 1305, 8.879871,
15.72245, 1305, 9.039085,
16.37755, 1305, 9.184614,
17.03265, 1305, 9.317408,
17.68776, 1305, 9.438394,
18.34286, 1305, 9.54847,
18.99796, 1305, 9.648496,
19.65306, 1305, 9.739289,
20.30816, 1305, 9.821619,
20.96326, 1305, 9.896207,
21.61837, 1305, 9.963726,
22.27347, 1305, 10.0248,
22.92857, 1305, 10.08001,
23.58367, 1305, 10.1299,
24.23878, 1305, 10.17494,
24.89388, 1305, 10.21559,
25.54898, 1305, 10.25226,
26.20408, 1305, 10.28534,
26.85918, 1305, 10.31516,
27.51429, 1305, 10.34203,
28.16939, 1305, 10.36624,
28.82449, 1305, 10.38805,
29.47959, 1305, 10.40769,
30.13469, 1305, 10.42537,
30.7898, 1305, 10.44129,
31.4449, 1305, 10.45561,
32.1, 1305, 10.46851
]);
var buf118 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf118);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc118 = gl.getUniformLocation(prog118,"mvMatrix");
var prMatLoc118 = gl.getUniformLocation(prog118,"prMatrix");
// ****** linestrip object 119 ******
var prog119  = gl.createProgram();
gl.attachShader(prog119, getShader( gl, "unnamed_chunk_4vshader119" ));
gl.attachShader(prog119, getShader( gl, "unnamed_chunk_4fshader119" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog119, 0, "aPos");
gl.bindAttribLocation(prog119, 1, "aCol");
gl.linkProgram(prog119);
var v=new Float32Array([
0, 1310, 1.37,
0.655102, 1310, 1.627141,
1.310204, 1310, 1.901629,
1.965306, 1310, 2.190177,
2.620408, 1310, 2.489319,
3.27551, 1310, 2.795561,
3.930612, 1310, 3.105512,
4.585714, 1310, 3.415987,
5.240816, 1310, 3.724083,
5.895918, 1310, 4.02723,
6.551021, 1310, 4.323217,
7.206122, 1310, 4.610202,
7.861225, 1310, 4.886703,
8.516327, 1310, 5.151577,
9.171429, 1310, 5.404,
9.82653, 1310, 5.643424,
10.48163, 1310, 5.86955,
11.13673, 1310, 6.082293,
11.79184, 1310, 6.281743,
12.44694, 1310, 6.468137,
13.10204, 1310, 6.641829,
13.75714, 1310, 6.803262,
14.41224, 1310, 6.952946,
15.06735, 1310, 7.091439,
15.72245, 1310, 7.21933,
16.37755, 1310, 7.337221,
17.03265, 1310, 7.445721,
17.68776, 1310, 7.545434,
18.34286, 1310, 7.636952,
18.99796, 1310, 7.720848,
19.65306, 1310, 7.797674,
20.30816, 1310, 7.867957,
20.96326, 1310, 7.932198,
21.61837, 1310, 7.990869,
22.27347, 1310, 8.044414,
22.92857, 1310, 8.093248,
23.58367, 1310, 8.137761,
24.23878, 1310, 8.178311,
24.89388, 1310, 8.215235,
25.54898, 1310, 8.24884,
26.20408, 1310, 8.279413,
26.85918, 1310, 8.307219,
27.51429, 1310, 8.332498,
28.16939, 1310, 8.355473,
28.82449, 1310, 8.376348,
29.47959, 1310, 8.395312,
30.13469, 1310, 8.412535,
30.7898, 1310, 8.428174,
31.4449, 1310, 8.442371,
32.1, 1310, 8.455258
]);
var buf119 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf119);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc119 = gl.getUniformLocation(prog119,"mvMatrix");
var prMatLoc119 = gl.getUniformLocation(prog119,"prMatrix");
// ****** linestrip object 120 ******
var prog120  = gl.createProgram();
gl.attachShader(prog120, getShader( gl, "unnamed_chunk_4vshader120" ));
gl.attachShader(prog120, getShader( gl, "unnamed_chunk_4fshader120" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog120, 0, "aPos");
gl.bindAttribLocation(prog120, 1, "aCol");
gl.linkProgram(prog120);
var v=new Float32Array([
0, 1320, 1.37,
0.655102, 1320, 1.609683,
1.310204, 1320, 1.863604,
1.965306, 1320, 2.128858,
2.620408, 1320, 2.402436,
3.27551, 1320, 2.681347,
3.930612, 1320, 2.962715,
4.585714, 1320, 3.243855,
5.240816, 1320, 3.522336,
5.895918, 1320, 3.796011,
6.551021, 1320, 4.063037,
7.206122, 1320, 4.321881,
7.861225, 1320, 4.571311,
8.516327, 1320, 4.810378,
9.171429, 1320, 5.038393,
9.82653, 1320, 5.254903,
10.48163, 1320, 5.459658,
11.13673, 1320, 5.652588,
11.79184, 1320, 5.83377,
12.44694, 1320, 6.003404,
13.10204, 1320, 6.16179,
13.75714, 1320, 6.309304,
14.41224, 1320, 6.446381,
15.06735, 1320, 6.573496,
15.72245, 1320, 6.691153,
16.37755, 1320, 6.799869,
17.03265, 1320, 6.900168,
17.68776, 1320, 6.992573,
18.34286, 1320, 7.077595,
18.99796, 1320, 7.155735,
19.65306, 1320, 7.227472,
20.30816, 1320, 7.293269,
20.96326, 1320, 7.353565,
21.61837, 1320, 7.408776,
22.27347, 1320, 7.459295,
22.92857, 1320, 7.505491,
23.58367, 1320, 7.547708,
24.23878, 1320, 7.586267,
24.89388, 1320, 7.62147,
25.54898, 1320, 7.653594,
26.20408, 1320, 7.682895,
26.85918, 1320, 7.709613,
27.51429, 1320, 7.733967,
28.16939, 1320, 7.756159,
28.82449, 1320, 7.776376,
29.47959, 1320, 7.794789,
30.13469, 1320, 7.811555,
30.7898, 1320, 7.826818,
31.4449, 1320, 7.840711,
32.1, 1320, 7.853354
]);
var buf120 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf120);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc120 = gl.getUniformLocation(prog120,"mvMatrix");
var prMatLoc120 = gl.getUniformLocation(prog120,"prMatrix");
// ****** linestrip object 121 ******
var prog121  = gl.createProgram();
gl.attachShader(prog121, getShader( gl, "unnamed_chunk_4vshader121" ));
gl.attachShader(prog121, getShader( gl, "unnamed_chunk_4fshader121" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog121, 0, "aPos");
gl.bindAttribLocation(prog121, 1, "aCol");
gl.linkProgram(prog121);
var v=new Float32Array([
0, 1321, 1.37,
0.655102, 1321, 1.644534,
1.310204, 1321, 1.939767,
1.965306, 1321, 2.252017,
2.620408, 1321, 2.577332,
3.27551, 1321, 2.911677,
3.930612, 1321, 3.251099,
4.585714, 1321, 3.591862,
5.240816, 1321, 3.930546,
5.895918, 1321, 4.264116,
6.551021, 1321, 4.589959,
7.206122, 1321, 4.905895,
7.861225, 1321, 5.210173,
8.516327, 1321, 5.501447,
9.171429, 1321, 5.778745,
9.82653, 1321, 6.04143,
10.48163, 1321, 6.289157,
11.13673, 1321, 6.52183,
11.79184, 1321, 6.739564,
12.44694, 1321, 6.942643,
13.10204, 1321, 7.131486,
13.75714, 1321, 7.306615,
14.41224, 1321, 7.468629,
15.06735, 1321, 7.618177,
15.72245, 1321, 7.755943,
16.37755, 1321, 7.882625,
17.03265, 1321, 7.998924,
17.68776, 1321, 8.105534,
18.34286, 1321, 8.203131,
18.99796, 1321, 8.292368,
19.65306, 1321, 8.373873,
20.30816, 1321, 8.448241,
20.96326, 1321, 8.516039,
21.61837, 1321, 8.577795,
22.27347, 1321, 8.634007,
22.92857, 1321, 8.68514,
23.58367, 1321, 8.731624,
24.23878, 1321, 8.773859,
24.89388, 1321, 8.812215,
25.54898, 1321, 8.847033,
26.20408, 1321, 8.878626,
26.85918, 1321, 8.907283,
27.51429, 1321, 8.933269,
28.16939, 1321, 8.956824,
28.82449, 1321, 8.978172,
29.47959, 1321, 8.997515,
30.13469, 1321, 9.015035,
30.7898, 1321, 9.030903,
31.4449, 1321, 9.045272,
32.1, 1321, 9.058281
]);
var buf121 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf121);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc121 = gl.getUniformLocation(prog121,"mvMatrix");
var prMatLoc121 = gl.getUniformLocation(prog121,"prMatrix");
// ****** linestrip object 122 ******
var prog122  = gl.createProgram();
gl.attachShader(prog122, getShader( gl, "unnamed_chunk_4vshader122" ));
gl.attachShader(prog122, getShader( gl, "unnamed_chunk_4fshader122" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog122, 0, "aPos");
gl.bindAttribLocation(prog122, 1, "aCol");
gl.linkProgram(prog122);
var v=new Float32Array([
0, 1325, 1.37,
0.655102, 1325, 1.690869,
1.310204, 1325, 2.042578,
1.965306, 1325, 2.420343,
2.620408, 1325, 2.818765,
3.27551, 1325, 3.232144,
3.930612, 1325, 3.654779,
4.585714, 1325, 4.081203,
5.240816, 1325, 4.506373,
5.895918, 1325, 4.925798,
6.551021, 1325, 5.33561,
7.206122, 1325, 5.732602,
7.861225, 1325, 6.114214,
8.516327, 1325, 6.478507,
9.171429, 1325, 6.824105,
9.82653, 1325, 7.150139,
10.48163, 1325, 7.456175,
11.13673, 1325, 7.742144,
11.79184, 1325, 8.008282,
12.44694, 1325, 8.255064,
13.10204, 1325, 8.48315,
13.75714, 1325, 8.69334,
14.41224, 1325, 8.886527,
15.06735, 1325, 9.063666,
15.72245, 1325, 9.225746,
16.37755, 1325, 9.373764,
17.03265, 1325, 9.508708,
17.68776, 1325, 9.631544,
18.34286, 1325, 9.743204,
18.99796, 1325, 9.844578,
19.65306, 1325, 9.936511,
20.30816, 1325, 10.0198,
20.96326, 1325, 10.09519,
21.61837, 1325, 10.16337,
22.27347, 1325, 10.22499,
22.92857, 1325, 10.28065,
23.58367, 1325, 10.33088,
24.23878, 1325, 10.37621,
24.89388, 1325, 10.41707,
25.54898, 1325, 10.45391,
26.20408, 1325, 10.4871,
26.85918, 1325, 10.517,
27.51429, 1325, 10.54392,
28.16939, 1325, 10.56815,
28.82449, 1325, 10.58996,
29.47959, 1325, 10.60959,
30.13469, 1325, 10.62724,
30.7898, 1325, 10.64312,
31.4449, 1325, 10.65739,
32.1, 1325, 10.67023
]);
var buf122 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf122);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc122 = gl.getUniformLocation(prog122,"mvMatrix");
var prMatLoc122 = gl.getUniformLocation(prog122,"prMatrix");
// ****** linestrip object 123 ******
var prog123  = gl.createProgram();
gl.attachShader(prog123, getShader( gl, "unnamed_chunk_4vshader123" ));
gl.attachShader(prog123, getShader( gl, "unnamed_chunk_4fshader123" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog123, 0, "aPos");
gl.bindAttribLocation(prog123, 1, "aCol");
gl.linkProgram(prog123);
var v=new Float32Array([
0, 1325, 1.37,
0.655102, 1325, 1.568398,
1.310204, 1325, 1.774716,
1.965306, 1325, 1.986895,
2.620408, 1325, 2.202891,
3.27551, 1325, 2.420738,
3.930612, 1325, 2.638592,
4.585714, 1325, 2.854766,
5.240816, 1325, 3.067756,
5.895918, 1325, 3.276252,
6.551021, 1325, 3.479143,
7.206122, 1325, 3.675511,
7.861225, 1325, 3.864628,
8.516327, 1325, 4.045938,
9.171429, 1325, 4.219048,
9.82653, 1325, 4.383704,
10.48163, 1325, 4.539779,
11.13673, 1325, 4.687254,
11.79184, 1325, 4.826201,
12.44694, 1325, 4.95677,
13.10204, 1325, 5.07917,
13.75714, 1325, 5.19366,
14.41224, 1325, 5.300535,
15.06735, 1325, 5.40012,
15.72245, 1325, 5.492756,
16.37755, 1325, 5.578795,
17.03265, 1325, 5.658595,
17.68776, 1325, 5.732514,
18.34286, 1325, 5.800905,
18.99796, 1325, 5.864114,
19.65306, 1325, 5.922476,
20.30816, 1325, 5.976315,
20.96326, 1325, 6.025941,
21.61837, 1325, 6.07165,
22.27347, 1325, 6.113721,
22.92857, 1325, 6.152421,
23.58367, 1325, 6.187998,
24.23878, 1325, 6.220689,
24.89388, 1325, 6.250713,
25.54898, 1325, 6.278275,
26.20408, 1325, 6.303568,
26.85918, 1325, 6.326769,
27.51429, 1325, 6.348045,
28.16939, 1325, 6.36755,
28.82449, 1325, 6.385426,
29.47959, 1325, 6.401804,
30.13469, 1325, 6.416808,
30.7898, 1325, 6.430549,
31.4449, 1325, 6.443131,
32.1, 1325, 6.45465
]);
var buf123 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf123);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc123 = gl.getUniformLocation(prog123,"mvMatrix");
var prMatLoc123 = gl.getUniformLocation(prog123,"prMatrix");
// ****** linestrip object 124 ******
var prog124  = gl.createProgram();
gl.attachShader(prog124, getShader( gl, "unnamed_chunk_4vshader124" ));
gl.attachShader(prog124, getShader( gl, "unnamed_chunk_4fshader124" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog124, 0, "aPos");
gl.bindAttribLocation(prog124, 1, "aCol");
gl.linkProgram(prog124);
var v=new Float32Array([
0, 1329, 1.37,
0.655102, 1329, 1.597985,
1.310204, 1329, 1.838269,
1.965306, 1329, 2.088195,
2.620408, 1329, 2.345045,
3.27551, 1329, 2.60614,
3.930612, 1329, 2.868922,
4.585714, 1329, 3.131018,
5.240816, 1329, 3.390282,
5.895918, 1329, 3.644829,
6.551021, 1329, 3.893042,
7.206122, 1329, 4.13358,
7.861225, 1329, 4.365366,
8.516327, 1329, 4.587571,
9.171429, 1329, 4.799595,
9.82653, 1329, 5.001045,
10.48163, 1329, 5.191707,
11.13673, 1329, 5.371521,
11.79184, 1329, 5.540561,
12.44694, 1329, 5.699009,
13.10204, 1329, 5.847134,
13.75714, 1329, 5.985272,
14.41224, 1329, 6.113815,
15.06735, 1329, 6.233188,
15.72245, 1329, 6.343843,
16.37755, 1329, 6.446248,
17.03265, 1329, 6.540873,
17.68776, 1329, 6.62819,
18.34286, 1329, 6.708663,
18.99796, 1329, 6.782742,
19.65306, 1329, 6.850866,
20.30816, 1329, 6.913455,
20.96326, 1329, 6.970908,
21.61837, 1329, 7.023606,
22.27347, 1329, 7.071908,
22.92857, 1329, 7.116152,
23.58367, 1329, 7.156656,
24.23878, 1329, 7.193715,
24.89388, 1329, 7.227605,
25.54898, 1329, 7.258585,
26.20408, 1329, 7.286893,
26.85918, 1329, 7.312749,
27.51429, 1329, 7.336359,
28.16939, 1329, 7.357909,
28.82449, 1329, 7.377576,
29.47959, 1329, 7.395519,
30.13469, 1329, 7.411885,
30.7898, 1329, 7.426809,
31.4449, 1329, 7.440417,
32.1, 1329, 7.452822
]);
var buf124 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf124);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc124 = gl.getUniformLocation(prog124,"mvMatrix");
var prMatLoc124 = gl.getUniformLocation(prog124,"prMatrix");
// ****** linestrip object 125 ******
var prog125  = gl.createProgram();
gl.attachShader(prog125, getShader( gl, "unnamed_chunk_4vshader125" ));
gl.attachShader(prog125, getShader( gl, "unnamed_chunk_4fshader125" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog125, 0, "aPos");
gl.bindAttribLocation(prog125, 1, "aCol");
gl.linkProgram(prog125);
var v=new Float32Array([
0, 1332, 1.37,
0.655102, 1332, 1.627141,
1.310204, 1332, 1.901629,
1.965306, 1332, 2.190177,
2.620408, 1332, 2.489319,
3.27551, 1332, 2.795561,
3.930612, 1332, 3.105512,
4.585714, 1332, 3.415987,
5.240816, 1332, 3.724083,
5.895918, 1332, 4.02723,
6.551021, 1332, 4.323217,
7.206122, 1332, 4.610202,
7.861225, 1332, 4.886703,
8.516327, 1332, 5.151577,
9.171429, 1332, 5.404,
9.82653, 1332, 5.643424,
10.48163, 1332, 5.86955,
11.13673, 1332, 6.082293,
11.79184, 1332, 6.281743,
12.44694, 1332, 6.468137,
13.10204, 1332, 6.641829,
13.75714, 1332, 6.803262,
14.41224, 1332, 6.952946,
15.06735, 1332, 7.091439,
15.72245, 1332, 7.21933,
16.37755, 1332, 7.337221,
17.03265, 1332, 7.445721,
17.68776, 1332, 7.545434,
18.34286, 1332, 7.636952,
18.99796, 1332, 7.720848,
19.65306, 1332, 7.797674,
20.30816, 1332, 7.867957,
20.96326, 1332, 7.932198,
21.61837, 1332, 7.990869,
22.27347, 1332, 8.044414,
22.92857, 1332, 8.093248,
23.58367, 1332, 8.137761,
24.23878, 1332, 8.178311,
24.89388, 1332, 8.215235,
25.54898, 1332, 8.24884,
26.20408, 1332, 8.279413,
26.85918, 1332, 8.307219,
27.51429, 1332, 8.332498,
28.16939, 1332, 8.355473,
28.82449, 1332, 8.376348,
29.47959, 1332, 8.395312,
30.13469, 1332, 8.412535,
30.7898, 1332, 8.428174,
31.4449, 1332, 8.442371,
32.1, 1332, 8.455258
]);
var buf125 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf125);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc125 = gl.getUniformLocation(prog125,"mvMatrix");
var prMatLoc125 = gl.getUniformLocation(prog125,"prMatrix");
// ****** linestrip object 126 ******
var prog126  = gl.createProgram();
gl.attachShader(prog126, getShader( gl, "unnamed_chunk_4vshader126" ));
gl.attachShader(prog126, getShader( gl, "unnamed_chunk_4fshader126" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog126, 0, "aPos");
gl.bindAttribLocation(prog126, 1, "aCol");
gl.linkProgram(prog126);
var v=new Float32Array([
0, 1335, 1.37,
0.655102, 1335, 1.71413,
1.310204, 1335, 2.094841,
1.965306, 1335, 2.506773,
2.620408, 1335, 2.943713,
3.27551, 1335, 3.399,
3.930612, 1335, 3.865904,
4.585714, 1335, 4.337938,
5.240816, 1335, 4.809101,
5.895918, 1335, 5.274046,
6.551021, 1335, 5.728183,
7.206122, 1335, 6.167716,
7.861225, 1335, 6.589639,
8.516327, 1335, 6.991694,
9.171429, 1335, 7.372306,
9.82653, 1335, 7.730505,
10.48163, 1335, 8.065841,
11.13673, 1335, 8.378293,
11.79184, 1335, 8.6682,
12.44694, 1335, 8.936173,
13.10204, 1335, 9.183036,
13.75714, 1335, 9.409764,
14.41224, 1335, 9.617436,
15.06735, 1335, 9.807194,
15.72245, 1335, 9.980206,
16.37755, 1335, 10.13764,
17.03265, 1335, 10.28066,
17.68776, 1335, 10.41038,
18.34286, 1335, 10.52787,
18.99796, 1335, 10.63414,
19.65306, 1335, 10.73018,
20.30816, 1335, 10.81687,
20.96326, 1335, 10.89505,
21.61837, 1335, 10.9655,
22.27347, 1335, 11.02895,
22.92857, 1335, 11.08605,
23.58367, 1335, 11.1374,
24.23878, 1335, 11.18357,
24.89388, 1335, 11.22505,
25.54898, 1335, 11.26231,
26.20408, 1335, 11.29576,
26.85918, 1335, 11.32578,
27.51429, 1335, 11.35272,
28.16939, 1335, 11.37689,
28.82449, 1335, 11.39857,
29.47959, 1335, 11.418,
30.13469, 1335, 11.43542,
30.7898, 1335, 11.45104,
31.4449, 1335, 11.46503,
32.1, 1335, 11.47757
]);
var buf126 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf126);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc126 = gl.getUniformLocation(prog126,"mvMatrix");
var prMatLoc126 = gl.getUniformLocation(prog126,"prMatrix");
// ****** linestrip object 127 ******
var prog127  = gl.createProgram();
gl.attachShader(prog127, getShader( gl, "unnamed_chunk_4vshader127" ));
gl.attachShader(prog127, getShader( gl, "unnamed_chunk_4fshader127" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog127, 0, "aPos");
gl.bindAttribLocation(prog127, 1, "aCol");
gl.linkProgram(prog127);
var v=new Float32Array([
0, 1351, 1.37,
0.655102, 1351, 1.603841,
1.310204, 1351, 1.850938,
1.965306, 1351, 2.108509,
2.620408, 1351, 2.373693,
3.27551, 1351, 2.643657,
3.930612, 1351, 2.915686,
4.585714, 1351, 3.187254,
5.240816, 1351, 3.456075,
5.895918, 1351, 3.720134,
6.551021, 1351, 3.977704,
7.206122, 1351, 4.22735,
7.861225, 1351, 4.467917,
8.516327, 1351, 4.698518,
9.171429, 1351, 4.918509,
9.82653, 1351, 5.127466,
10.48163, 1351, 5.325157,
11.13673, 1351, 5.511518,
11.79184, 1351, 5.686625,
12.44694, 1351, 5.850666,
13.10204, 1351, 6.003925,
13.75714, 1351, 6.14676,
14.41224, 1351, 6.279581,
15.06735, 1351, 6.402839,
15.72245, 1351, 6.517012,
16.37755, 1351, 6.622591,
17.03265, 1351, 6.720073,
17.68776, 1351, 6.809954,
18.34286, 1351, 6.892723,
18.99796, 1351, 6.968854,
19.65306, 1351, 7.038807,
20.30816, 1351, 7.103021,
20.96326, 1351, 7.161917,
21.61837, 1351, 7.215892,
22.27347, 1351, 7.265323,
22.92857, 1351, 7.310562,
23.58367, 1351, 7.35194,
24.23878, 1351, 7.389767,
24.89388, 1351, 7.42433,
25.54898, 1351, 7.455898,
26.20408, 1351, 7.484717,
26.85918, 1351, 7.511018,
27.51429, 1351, 7.535013,
28.16939, 1351, 7.556897,
28.82449, 1351, 7.57685,
29.47959, 1351, 7.595038,
30.13469, 1351, 7.611614,
30.7898, 1351, 7.626717,
31.4449, 1351, 7.640476,
32.1, 1351, 7.653008
]);
var buf127 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf127);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc127 = gl.getUniformLocation(prog127,"mvMatrix");
var prMatLoc127 = gl.getUniformLocation(prog127,"prMatrix");
// ****** linestrip object 128 ******
var prog128  = gl.createProgram();
gl.attachShader(prog128, getShader( gl, "unnamed_chunk_4vshader128" ));
gl.attachShader(prog128, getShader( gl, "unnamed_chunk_4fshader128" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog128, 0, "aPos");
gl.bindAttribLocation(prog128, 1, "aCol");
gl.linkProgram(prog128);
var v=new Float32Array([
0, 1355, 1.37,
0.655102, 1355, 1.556365,
1.310204, 1355, 1.749087,
1.965306, 1355, 1.946337,
2.620408, 1355, 2.146321,
3.27551, 1355, 2.347331,
3.930612, 1355, 2.547777,
4.585714, 1355, 2.746218,
5.240816, 1355, 2.941373,
5.895918, 1355, 3.132133,
6.551021, 1355, 3.317565,
7.206122, 1355, 3.496901,
7.861225, 1355, 3.669534,
8.516327, 1355, 3.835009,
9.171429, 1355, 3.993003,
9.82653, 1355, 4.143317,
10.48163, 1355, 4.285856,
11.13673, 1355, 4.420619,
11.79184, 1355, 4.547681,
12.44694, 1355, 4.667181,
13.10204, 1355, 4.779312,
13.75714, 1355, 4.884307,
14.41224, 1355, 4.982432,
15.06735, 1355, 5.073974,
15.72245, 1355, 5.159237,
16.37755, 1355, 5.238536,
17.03265, 1355, 5.312187,
17.68776, 1355, 5.380508,
18.34286, 1355, 5.443814,
18.99796, 1355, 5.502411,
19.65306, 1355, 5.556599,
20.30816, 1355, 5.606665,
20.96326, 1355, 5.652887,
21.61837, 1355, 5.695529,
22.27347, 1355, 5.734842,
22.92857, 1355, 5.771063,
23.58367, 1355, 5.804417,
24.23878, 1355, 5.835116,
24.89388, 1355, 5.863358,
25.54898, 1355, 5.889327,
26.20408, 1355, 5.913198,
26.85918, 1355, 5.935133,
27.51429, 1355, 5.955281,
28.16939, 1355, 5.973783,
28.82449, 1355, 5.990769,
29.47959, 1355, 6.006359,
30.13469, 1355, 6.020663,
30.7898, 1355, 6.033787,
31.4449, 1355, 6.045824,
32.1, 1355, 6.056863
]);
var buf128 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf128);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc128 = gl.getUniformLocation(prog128,"mvMatrix");
var prMatLoc128 = gl.getUniformLocation(prog128,"prMatrix");
// ****** linestrip object 129 ******
var prog129  = gl.createProgram();
gl.attachShader(prog129, getShader( gl, "unnamed_chunk_4vshader129" ));
gl.attachShader(prog129, getShader( gl, "unnamed_chunk_4fshader129" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog129, 0, "aPos");
gl.bindAttribLocation(prog129, 1, "aCol");
gl.linkProgram(prog129);
var v=new Float32Array([
0, 1355, 1.37,
0.655102, 1355, 1.544171,
1.310204, 1355, 1.723248,
1.965306, 1355, 1.905624,
2.620408, 1355, 2.089746,
3.27551, 1355, 2.274147,
3.930612, 1355, 2.457476,
4.585714, 1355, 2.638517,
5.240816, 1355, 2.816198,
5.895918, 1355, 2.989598,
6.551021, 1355, 3.157943,
7.206122, 1355, 3.320605,
7.861225, 1355, 3.477092,
8.516327, 1355, 3.627036,
9.171429, 1355, 3.770186,
9.82653, 1355, 3.90639,
10.48163, 1355, 4.035586,
11.13673, 1355, 4.15779,
11.79184, 1355, 4.273079,
12.44694, 1355, 4.381588,
13.10204, 1355, 4.483492,
13.75714, 1355, 4.579003,
14.41224, 1355, 4.668357,
15.06735, 1355, 4.751812,
15.72245, 1355, 4.829638,
16.37755, 1355, 4.90211,
17.03265, 1355, 4.969511,
17.68776, 1355, 5.03212,
18.34286, 1355, 5.090215,
18.99796, 1355, 5.144068,
19.65306, 1355, 5.193944,
20.30816, 1355, 5.240096,
20.96326, 1355, 5.28277,
21.61837, 1355, 5.3222,
22.27347, 1355, 5.358611,
22.92857, 1355, 5.392211,
23.58367, 1355, 5.423203,
24.23878, 1355, 5.451774,
24.89388, 1355, 5.478101,
25.54898, 1355, 5.50235,
26.20408, 1355, 5.524677,
26.85918, 1355, 5.545227,
27.51429, 1355, 5.564135,
28.16939, 1355, 5.581527,
28.82449, 1355, 5.59752,
29.47959, 1355, 5.612224,
30.13469, 1355, 5.625739,
30.7898, 1355, 5.638158,
31.4449, 1355, 5.649569,
32.1, 1355, 5.660051
]);
var buf129 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf129);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc129 = gl.getUniformLocation(prog129,"mvMatrix");
var prMatLoc129 = gl.getUniformLocation(prog129,"prMatrix");
// ****** linestrip object 130 ******
var prog130  = gl.createProgram();
gl.attachShader(prog130, getShader( gl, "unnamed_chunk_4vshader130" ));
gl.attachShader(prog130, getShader( gl, "unnamed_chunk_4fshader130" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog130, 0, "aPos");
gl.bindAttribLocation(prog130, 1, "aCol");
gl.linkProgram(prog130);
var v=new Float32Array([
0, 1360, 1.37,
0.655102, 1360, 1.471801,
1.310204, 1360, 1.572717,
1.965306, 1360, 1.672242,
2.620408, 1360, 1.769928,
3.27551, 1360, 1.865387,
3.930612, 1360, 1.958289,
4.585714, 1360, 2.048362,
5.240816, 1360, 2.135387,
5.895918, 1360, 2.219197,
6.551021, 1360, 2.299669,
7.206122, 1360, 2.376721,
7.861225, 1360, 2.450311,
8.516327, 1360, 2.520428,
9.171429, 1360, 2.587089,
9.82653, 1360, 2.650336,
10.48163, 1360, 2.710232,
11.13673, 1360, 2.766854,
11.79184, 1360, 2.820297,
12.44694, 1360, 2.870665,
13.10204, 1360, 2.918067,
13.75714, 1360, 2.962623,
14.41224, 1360, 3.004454,
15.06735, 1360, 3.043684,
15.72245, 1360, 3.080437,
16.37755, 1360, 3.114838,
17.03265, 1360, 3.14701,
17.68776, 1360, 3.177072,
18.34286, 1360, 3.205143,
18.99796, 1360, 3.231336,
19.65306, 1360, 3.255762,
20.30816, 1360, 3.278526,
20.96326, 1360, 3.29973,
21.61837, 1360, 3.319472,
22.27347, 1360, 3.337842,
22.92857, 1360, 3.35493,
23.58367, 1360, 3.370819,
24.23878, 1360, 3.385587,
24.89388, 1360, 3.399308,
25.54898, 1360, 3.412053,
26.20408, 1360, 3.423888,
26.85918, 1360, 3.434875,
27.51429, 1360, 3.445072,
28.16939, 1360, 3.454534,
28.82449, 1360, 3.463311,
29.47959, 1360, 3.471452,
30.13469, 1360, 3.479002,
30.7898, 1360, 3.486002,
31.4449, 1360, 3.492491,
32.1, 1360, 3.498506
]);
var buf130 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf130);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc130 = gl.getUniformLocation(prog130,"mvMatrix");
var prMatLoc130 = gl.getUniformLocation(prog130,"prMatrix");
// ****** linestrip object 131 ******
var prog131  = gl.createProgram();
gl.attachShader(prog131, getShader( gl, "unnamed_chunk_4vshader131" ));
gl.attachShader(prog131, getShader( gl, "unnamed_chunk_4fshader131" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog131, 0, "aPos");
gl.bindAttribLocation(prog131, 1, "aCol");
gl.linkProgram(prog131);
var v=new Float32Array([
0, 1365, 1.37,
0.655102, 1365, 1.592112,
1.310204, 1365, 1.825593,
1.965306, 1365, 2.067909,
2.620408, 1365, 2.316483,
3.27551, 1365, 2.568786,
3.930612, 1365, 2.822411,
4.585714, 1365, 3.075133,
5.240816, 1365, 3.324943,
5.895918, 1365, 3.570079,
6.551021, 1365, 3.809033,
7.206122, 1365, 4.040555,
7.861225, 1365, 4.263641,
8.516327, 1365, 4.477522,
9.171429, 1365, 4.681639,
9.82653, 1365, 4.875629,
10.48163, 1365, 5.059295,
11.13673, 1365, 5.232586,
11.79184, 1365, 5.395574,
12.44694, 1365, 5.548432,
13.10204, 1365, 5.691415,
13.75714, 1365, 5.824843,
14.41224, 1365, 5.949086,
15.06735, 1365, 6.064547,
15.72245, 1365, 6.171653,
16.37755, 1365, 6.270848,
17.03265, 1365, 6.362578,
17.68776, 1365, 6.44729,
18.34286, 1365, 6.525424,
18.99796, 1365, 6.597411,
19.65306, 1365, 6.663664,
20.30816, 1365, 6.724584,
20.96326, 1365, 6.780553,
21.61837, 1365, 6.831933,
22.27347, 1365, 6.879067,
22.92857, 1365, 6.922278,
23.58367, 1365, 6.96187,
24.23878, 1365, 6.998126,
24.89388, 1365, 7.031311,
25.54898, 1365, 7.061671,
26.20408, 1365, 7.089437,
26.85918, 1365, 7.11482,
27.51429, 1365, 7.138017,
28.16939, 1365, 7.15921,
28.82449, 1365, 7.178567,
29.47959, 1365, 7.196242,
30.13469, 1365, 7.212378,
30.7898, 1365, 7.227105,
31.4449, 1365, 7.240545,
32.1, 1365, 7.252807
]);
var buf131 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf131);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc131 = gl.getUniformLocation(prog131,"mvMatrix");
var prMatLoc131 = gl.getUniformLocation(prog131,"prMatrix");
// ****** linestrip object 132 ******
var prog132  = gl.createProgram();
gl.attachShader(prog132, getShader( gl, "unnamed_chunk_4vshader132" ));
gl.attachShader(prog132, getShader( gl, "unnamed_chunk_4fshader132" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog132, 0, "aPos");
gl.bindAttribLocation(prog132, 1, "aCol");
gl.linkProgram(prog132);
var v=new Float32Array([
0, 1400, 1.37,
0.655102, 1400, 1.650324,
1.310204, 1400, 1.952518,
1.965306, 1400, 2.272768,
2.620408, 1400, 2.606951,
3.27551, 1400, 2.950843,
3.930612, 1400, 3.300293,
4.585714, 1400, 3.651369,
5.240816, 1400, 4.00047,
5.895918, 1400, 4.344395,
6.551021, 1400, 4.680387,
7.206122, 1400, 5.006152,
7.861225, 1400, 5.319842,
8.516327, 1400, 5.620041,
9.171429, 1400, 5.905729,
9.82653, 1400, 6.176236,
10.48163, 1400, 6.431205,
11.13673, 1400, 6.670538,
11.79184, 1400, 6.89436,
12.44694, 1400, 7.102974,
13.10204, 1400, 7.296824,
13.75714, 1400, 7.47646,
14.41224, 1400, 7.642513,
15.06735, 1400, 7.795667,
15.72245, 1400, 7.936638,
16.37755, 1400, 8.066159,
17.03265, 1400, 8.184964,
17.68776, 1400, 8.293777,
18.34286, 1400, 8.393304,
18.99796, 1400, 8.484227,
19.65306, 1400, 8.5672,
20.30816, 1400, 8.64284,
20.96326, 1400, 8.711737,
21.61837, 1400, 8.774438,
22.27347, 1400, 8.831461,
22.92857, 1400, 8.883285,
23.58367, 1400, 8.930355,
24.23878, 1400, 8.973085,
24.89388, 1400, 9.011857,
25.54898, 1400, 9.047021,
26.20408, 1400, 9.078901,
26.85918, 1400, 9.107793,
27.51429, 1400, 9.133967,
28.16939, 1400, 9.157675,
28.82449, 1400, 9.179141,
29.47959, 1400, 9.198573,
30.13469, 1400, 9.216161,
30.7898, 1400, 9.232076,
31.4449, 1400, 9.246473,
32.1, 1400, 9.259499
]);
var buf132 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf132);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc132 = gl.getUniformLocation(prog132,"mvMatrix");
var prMatLoc132 = gl.getUniformLocation(prog132,"prMatrix");
// ****** points object 133 ******
var prog133  = gl.createProgram();
gl.attachShader(prog133, getShader( gl, "unnamed_chunk_4vshader133" ));
gl.attachShader(prog133, getShader( gl, "unnamed_chunk_4fshader133" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog133, 0, "aPos");
gl.bindAttribLocation(prog133, 1, "aCol");
gl.linkProgram(prog133);
var v=new Float32Array([
6.1, 1239, 3.5,
5.4, 1239, 3.5,
4.2, 1239, 3.5,
1.2, 1239, 1.75,
8, 1239, 4.5,
3.8, 1239, 3.5,
2.7, 1239, 2.5,
5.5, 1239, 4.5,
3.7, 1239, 3.5,
2.9, 1239, 2.5,
9.1, 1239, 5.5,
2.2, 1239, 1.75,
0.8, 1239, 1.75,
4.1, 1239, 2.5,
0.7, 1239, 1.75,
0.9, 1239, 1.75,
1.9, 1239, 1.75,
8.7, 1239, 5.5,
1.6, 1239, 1.75,
1.1, 1239, 1.75,
3.1, 1239, 3.5,
6.2, 1239, 4.5,
2.6, 1239, 2.5,
2.3, 1239, 1.75,
2.7, 1239, 2.5,
1.5, 1239, 1.75,
1.2, 1239, 1.75,
8.9, 1239, 4.5,
5.8, 1239, 3.5,
5, 1239, 3.5,
9.1, 1239, 4.5,
7.9, 1239, 3.5,
5.9, 1239, 3.5,
6.8, 1239, 4.5,
8.6, 1239, 4.5,
5.6, 1239, 3.5,
9.2, 1239, 7.5,
7.3, 1239, 3.5,
5.3, 1239, 4.5,
6, 1239, 4.5,
6, 1239, 3.5,
6.5, 1239, 4.5,
9.3, 1239, 5.5,
5.5, 1239, 3.5,
7.7, 1239, 3.5,
6.4, 1269, 4.5,
8, 1269, 3.5,
3, 1269, 2.5,
2.43, 1269, 1.75,
5.7, 1269, 4.5,
2.72, 1269, 2.5,
5.5, 1269, 3.5,
1.42, 1269, 1.75,
0.86, 1269, 1.75,
3.71, 1269, 3.5,
3.8, 1269, 2.5,
16.5, 1269, 5.5,
13.6, 1269, 6.5,
2.82, 1269, 2.5,
10.8, 1269, 4.5,
2.64, 1269, 2.5,
7.9, 1269, 4.5,
9.8, 1269, 5.5,
11.2, 1269, 5.5,
3.3, 1269, 3.5,
1.883, 1269, 1.75,
1.97, 1269, 2.5,
2.92, 1269, 1.75,
5.7, 1269, 3.5,
7.5, 1269, 4.5,
6.6, 1269, 4.5,
3.44, 1269, 2.5,
2.86, 1269, 3.5,
1.45, 1269, 1.75,
9.9, 1269, 4.5,
4.3, 1269, 3.5,
2.82, 1269, 2.5,
3.07, 1269, 1.75,
4.5, 1269, 3.5,
7.6, 1269, 4.5,
4.8, 1269, 4.5,
5.4, 1269, 3.5,
9.4, 1269, 5.5,
9.7, 1269, 5.5,
6.6, 1269, 4.5,
2.88, 1269, 2.5,
9.8, 1269, 3.5,
0.9, 1269, 1.75,
5.9, 1269, 3.5,
6.5, 1269, 3.5,
6.5, 1299, 2.5,
16, 1299, 4.5,
13.2, 1299, 5.5,
7.9, 1299, 3.5,
7.2, 1299, 3.5,
3, 1299, 1.75,
15.6, 1299, 6.5,
14.2, 1299, 6.5,
7.1, 1299, 3.5,
4.1, 1299, 1.75,
4, 1299, 2.5,
4.2, 1299, 1.75,
7.2, 1299, 3.5,
3.6, 1299, 2.5,
10, 1299, 5.5,
6.3, 1299, 2.5,
2.4, 1299, 1.75,
3, 1329, 2.5,
16.2, 1329, 5.5,
11.5, 1329, 3.5,
7.1, 1329, 3.5,
3.7, 1329, 2.5,
5.67, 1329, 3.5,
2.5, 1329, 1.75,
2.1, 1329, 1.75,
2.1, 1329, 2.5,
2.3, 1329, 1.75,
12.8, 1329, 6.5,
2.5, 1329, 1.75,
7.9, 1329, 3.5,
15.3, 1329, 3.5,
1.49, 1329, 1.75,
2.9, 1329, 2.5,
3, 1329, 1.75,
4.5, 1329, 3.5,
4.8, 1329, 3.5,
6.8, 1329, 3.5,
3.15, 1329, 2.5,
4.4, 1329, 3.5,
4.9, 1329, 2.5,
5.2, 1329, 3.5,
7.2, 1329, 4.5,
5.1, 1329, 4.5,
3.46, 1329, 3.5,
4.4, 1329, 3.5,
3.08, 1329, 2.5,
4.4, 1329, 2.5,
2.66, 1329, 1.75,
4.5, 1329, 2.5,
21.4, 1329, 7.5,
3.74, 1329, 2.5,
2.1358, 1329, 1.75,
2.33125, 1329, 1.75,
1.8277, 1329, 2.5,
4.6, 1329, 2.5,
4.9, 1329, 3.5,
3.47, 1329, 3.5,
4.8, 1329, 3.5,
2.37, 1329, 1.75,
7.2, 1360, 1.75,
5.6, 1360, 1.75,
2.3, 1360, 1.75,
17.3, 1240, 7.5,
13.9, 1240, 6.5,
3.2, 1240, 1.75,
4.7, 1240, 3.5,
4.6, 1240, 3.5,
13.2, 1240, 7.5,
6.8, 1240, 2.5,
8.2, 1240, 5.5,
2.8, 1240, 2.5,
4, 1240, 2.5,
3.7, 1240, 3.5,
4.1, 1240, 3.5,
2.5, 1240, 1.75,
14.8, 1240, 7.5,
7.2, 1240, 4.5,
10.6, 1240, 6.5,
14.8, 1240, 5.5,
3.9, 1240, 2.5,
4.8, 1240, 2.5,
3.3, 1240, 2.5,
3.6, 1240, 2.5,
8.8, 1240, 4.5,
3.5, 1240, 3.5,
4, 1240, 2.5,
13.2, 1240, 5.5,
16.9, 1240, 6.5,
5.8, 1240, 3.5,
8.9, 1240, 4.5,
9.3, 1240, 4.5,
14, 1240, 6.5,
9.7, 1240, 4.5,
2.7, 1240, 1.75,
9.1, 1271, 5.5,
6.2, 1271, 3.5,
4.7, 1271, 2.5,
16.1, 1271, 7.5,
8.9, 1271, 5.5,
10.1, 1271, 6.5,
2.989, 1271, 2.5,
4.6, 1271, 2.5,
6.9, 1271, 4.5,
3.23, 1271, 2.5,
11.8, 1271, 5.5,
9.8, 1271, 4.5,
5, 1271, 3.5,
8.5, 1271, 3.5,
3.96, 1271, 2.5,
18.1, 1271, 8.5,
15.6, 1271, 8.5,
8.1, 1271, 4.5,
4.9, 1271, 3.5,
6.4, 1271, 3.5,
11.7, 1302, 4.5,
9.3, 1302, 3.5,
10.9, 1302, 4.5,
7.2, 1302, 4.5,
6.5, 1302, 4.5,
3.6, 1302, 2.5,
11.9, 1302, 3.5,
10.8, 1302, 4.5,
7.6, 1302, 3.5,
3.226, 1302, 1.75,
9.5, 1302, 4.5,
10.2, 1302, 4.5,
8.2, 1302, 4.5,
2.9, 1302, 2.5,
7.9, 1302, 4.5,
11.2, 1302, 4.5,
9.8, 1302, 4.5,
8.5, 1302, 5.5,
5.1, 1302, 3.5,
4.1, 1302, 2.5,
16.6, 1302, 6.5,
5.5, 1302, 3.5,
6.2, 1302, 2.5,
7.3, 1302, 4.5,
7.8, 1302, 4.5,
5.2, 1302, 2.5,
4.5, 1302, 3.5,
6.4, 1302, 4.5,
3.384, 1302, 1.75,
6.3, 1302, 3.5,
4.6, 1332, 2.5,
2.3, 1332, 2.5,
7.2, 1332, 3.5,
18.6, 1332, 6.5,
8.7, 1332, 3.5,
10.6, 1332, 5.5,
4.6, 1332, 2.5,
15.3, 1332, 5.5,
6.7, 1332, 4.5,
21.4, 1332, 8.5,
4.2, 1332, 2.5,
5.7, 1332, 3.5,
16, 1332, 5.5,
4.1, 1231, 3.5,
2.6, 1231, 2.5,
2.6, 1231, 2.5,
4.6, 1231, 3.5,
4, 1231, 3.5,
3.4, 1231, 3.5,
6.9, 1231, 4.5,
3.1, 1231, 2.5,
1.6, 1231, 1.75,
2.2, 1231, 2.5,
2.3, 1231, 2.5,
3.1, 1231, 3.5,
3.6, 1231, 2.5,
1.9, 1231, 2.5,
5.9, 1231, 4.5,
1.2, 1231, 1.75,
2.9, 1231, 2.5,
6.1, 1231, 4.5,
5.2, 1231, 3.5,
7.4, 1231, 4.5,
4.2, 1231, 3.5,
2.9, 1231, 2.5,
5.3, 1231, 3.5,
13, 1231, 6.5,
5.1, 1231, 3.5,
7.4, 1231, 5.5,
3.1, 1231, 2.5,
5.2, 1231, 3.5,
5.9, 1231, 3.5,
8.9, 1231, 5.5,
8.2, 1231, 4.5,
4.4, 1231, 3.5,
1.8, 1231, 1.75,
4.2, 1231, 3.5,
5.8, 1231, 3.5,
8.3, 1261, 4.5,
2.2, 1261, 1.75,
7.7, 1261, 4.5,
3.1, 1261, 1.75,
16.5, 1261, 7.5,
2.6, 1261, 2.5,
7.2, 1261, 6.5,
20.9, 1261, 8.5,
10.6, 1320, 5.5,
2.4, 1320, 2.5,
15.4, 1320, 6.5,
12.2, 1320, 6.5,
5.7, 1320, 3.5,
4.9, 1320, 3.5,
14.7, 1320, 5.5,
6, 1320, 3.5,
2.9, 1320, 2.5,
13.2, 1320, 6.5,
17.9, 1320, 5.5,
15.1, 1321, 7.5,
2.95, 1321, 1.75,
21.4, 1321, 5.5,
8.3, 1321, 4.5,
6.4, 1321, 3.5,
5.7, 1321, 2.5,
7.4, 1321, 3.5,
11.4, 1321, 5.5,
6.9, 1321, 3.5,
5.1, 1321, 3.5,
11.4, 1321, 4.5,
13.3, 1321, 3.5,
5.8, 1321, 2.5,
2.57, 1321, 2.5,
21, 1321, 6.5,
13, 1321, 5.5,
3.1, 1321, 2.5,
6.4, 1321, 3.5,
5, 1321, 2.5,
12.5, 1321, 5.5,
3.3, 1351, 2.5,
4.7, 1351, 2.5,
7.4, 1351, 2.5,
11.8, 1351, 4.5,
6.5, 1351, 2.5,
1.58, 1351, 1.75,
3, 1351, 2.5,
4.6, 1351, 2.5,
7.1, 1351, 3.5,
1.9, 1351, 2.5,
8.8, 1351, 3.5,
6.3, 1351, 4.5,
7.1, 1351, 3.5,
6.8, 1351, 3.5,
5.1, 1351, 2.5,
1.78, 1351, 1.75,
1, 1351, 1.75,
6.2, 1351, 4.5,
4.45, 1351, 3.5,
1.92, 1351, 1.75,
7.3, 1351, 3.5,
3.4, 1351, 2.5,
1.53, 1351, 1.75,
1.77, 1351, 1.75,
5.3, 1351, 3.5,
6, 1351, 3.5,
10, 1351, 4.5,
3.2, 1351, 1.75,
2.7, 1351, 2.5,
2, 1351, 1.75,
7.4, 1351, 3.5,
6, 1351, 2.5,
5.7, 1351, 3.5,
3.2, 1351, 2.5,
3.1, 1351, 2.5,
4, 1351, 2.5,
5.5, 1351, 3.5,
3.1, 1351, 2.5,
10.4, 1351, 5.5,
12.2, 1351, 2.5,
4.9, 1351, 2.5,
5.7, 1351, 3.5,
7.9, 1351, 3.5,
1.12, 1351, 1.75,
4.5, 1351, 2.5,
11.8, 1351, 5.5,
4, 1351, 2.5,
3.2, 1351, 1.75,
5.6, 1351, 2.5,
13.2, 1351, 2.5,
2.9, 1351, 2.5,
4.7, 1351, 2.5,
7.9, 1351, 3.5,
1.7, 1351, 1.75,
6.9, 1351, 2.5,
2.8, 1351, 2.5,
2.9, 1351, 2.5,
8, 1351, 4.5,
6.7, 1351, 3.5,
5.7, 1351, 2.5,
7.8, 1351, 3.5,
5.8, 1351, 3.5,
7.5, 1351, 3.5,
5.6, 1351, 2.5,
5.6, 1351, 2.5,
1.3, 1351, 1.75,
6.8, 1351, 3.5,
6.8, 1351, 2.5,
3.9, 1351, 1.75,
5.3, 1351, 3.5,
7, 1351, 3.5,
5.5, 1310, 4.5,
6.2, 1310, 3.5,
5.8, 1310, 3.5,
2.2, 1310, 1.75,
5.4, 1310, 3.5,
3.6, 1310, 3.5,
7.2, 1310, 4.5,
7.2, 1310, 4.5,
5.7, 1310, 3.5,
1.25, 1310, 1.75,
2.64, 1310, 2.5,
9.5, 1310, 4.5,
9.9, 1310, 5.5,
3.64, 1310, 3.5,
1.16, 1310, 1.75,
1.05, 1310, 1.75,
2.5, 1310, 2.5,
2.68, 1310, 1.75,
8.5, 1310, 4.5,
3.8, 1310, 3.5,
6.9, 1310, 3.5,
6.5, 1310, 3.5,
11.7, 1310, 4.5,
2.15, 1310, 2.5,
1.55, 1310, 2.5,
3.2, 1310, 2.5,
7.8, 1310, 3.5,
7.6, 1310, 3.5,
9.8, 1310, 4.5,
5.2, 1310, 4.5,
4.6, 1310, 4.5,
9.3, 1310, 4.5,
1.74, 1310, 1.75,
4, 1310, 3.5,
1.7, 1310, 1.75,
10.1, 1310, 5.5,
0.85, 1310, 1.75,
8.1, 1310, 4.5,
7, 1310, 4.5,
2.17, 1310, 1.75,
5.2, 1310, 3.5,
2.7, 1310, 2.5,
1.89, 1310, 1.75,
6.2, 1310, 3.5,
4.6, 1310, 3.5,
6.1, 1310, 3.5,
3.9, 1310, 3.5,
7.5, 1310, 4.5,
2.4, 1310, 2.5,
4.6, 1310, 4.5,
12, 1310, 6.5,
11.5, 1310, 4.5,
9.7, 1310, 3.5,
5.6, 1310, 3.5,
1.47, 1310, 1.75,
3.1, 1310, 2.5,
3.4, 1310, 3.5,
3.4, 1310, 3.5,
3.09, 1310, 2.5,
5.8, 1310, 3.5,
1.57, 1310, 1.75,
9.8, 1310, 5.5,
2.1, 1310, 2.5,
9.2, 1310, 4.5,
2.81, 1310, 2.5,
3.89, 1310, 3.5,
3.5, 1310, 3.5,
17, 1400, 5.5,
14.7, 1400, 5.5,
14.2, 1400, 4.5,
6.4, 1400, 3.5,
7.9, 1400, 4.5,
8.7, 1400, 4.5,
9.9, 1400, 5.5,
12.5, 1400, 3.5,
10.2, 1400, 4.5,
5.7, 1400, 2.5,
6.7, 1400, 3.5,
6.1, 1400, 3.5,
6.1, 1400, 3.5,
16.1, 1400, 5.5,
13, 1400, 5.5,
11.6, 1400, 5.5,
7.4, 1400, 5.5,
8.1, 1400, 3.5,
10.2, 1400, 4.5,
16.2, 1400, 5.5,
2.11, 1400, 1.75,
6.5, 1400, 3.5,
11.1, 1400, 5.5,
8.7, 1400, 4.5,
8.2, 1400, 3.5,
8, 1400, 2.5,
5.8, 1400, 3.5,
7.5, 1400, 3.5,
4.05, 1400, 2.5,
6.4, 1400, 2.5,
9.4, 1400, 5.5,
5.2, 1400, 2.5,
9.2, 1400, 3.5,
1.02, 1400, 1.75,
2.28, 1400, 2.5,
6, 1400, 3.5,
6.4, 1400, 3.5,
3.3, 1400, 2.5,
8.9, 1400, 3.5,
10.3, 1400, 3.5,
4.9, 1400, 2.5,
3, 1189, 1.75,
5.4, 1189, 3.5,
7.7, 1189, 5.5,
1.44, 1189, 1.75,
5.3, 1189, 3.5,
2.9, 1189, 2.5,
8, 1189, 6.5,
10.4, 1189, 5.5,
3.9, 1189, 6.5,
9.1, 1189, 5.5,
9.1, 1189, 5.5,
8, 1189, 3.5,
2.9, 1189, 2.5,
6.7, 1189, 3.5,
3.3, 1189, 3.5,
2.4, 1189, 2.5,
2.2, 1189, 1.75,
7.8, 1189, 5.5,
8.2, 1189, 5.5,
5.5, 1189, 4.5,
4.8, 1189, 2.5,
2.6, 1189, 2.5,
7.5, 1189, 6.5,
2.594, 1189, 1.75,
5, 1189, 3.5,
8.3, 1189, 5.5,
5.9, 1189, 4.5,
3.1, 1189, 2.5,
2.989, 1189, 1.75,
3.3, 1189, 2.5,
3.9, 1189, 2.5,
5.7, 1189, 3.5,
3.3, 1189, 2.5,
4, 1189, 3.5,
3.6, 1189, 2.5,
2.357, 1189, 2.5,
1.646, 1189, 2.5,
2.7, 1189, 2.5,
3.5, 1189, 3.5,
4, 1189, 3.5,
3, 1189, 3.5,
2.2, 1189, 2.5,
5.8, 1189, 4.5,
5, 1189, 4.5,
3.2, 1189, 2.5,
3.7, 1189, 3.5,
4.9, 1189, 4.5,
7.9, 1189, 6.5,
3.1, 1189, 2.5,
2.9, 1189, 2.5,
3, 1189, 2.5,
6.2, 1189, 4.5,
8.5, 1189, 3.5,
8.2, 1189, 4.5,
6.1, 1189, 4.5,
7, 1189, 5.5,
3.6, 1189, 2.5,
5.2, 1189, 2.5,
6.2, 1189, 5.5,
6.2, 1189, 4.5,
6.8, 1189, 5.5,
8.2, 1189, 6.5,
7.3, 1189, 3.5,
6.1, 1189, 3.5,
8.9, 1189, 5.5,
6.6, 1189, 4.5,
8, 1219, 3.5,
3.4, 1219, 2.5,
5.1, 1219, 2.5,
6.5, 1219, 3.5,
6.4, 1219, 3.5,
9.7, 1219, 2.5,
8.6, 1219, 2.5,
4, 1219, 2.5,
3.8, 1219, 2.5,
3.4, 1219, 2.5,
5.2, 1219, 2.5,
2.1, 1219, 2.5,
4.6, 1219, 2.5,
2.5, 1219, 1.75,
7.9, 1219, 3.5,
8.1, 1219, 3.5,
2.3, 1219, 1.75,
4.6, 1219, 2.5,
6.3, 1219, 3.5,
6.6, 1219, 1.75,
5.1, 1219, 2.5,
5, 1219, 2.5,
2.8, 1219, 2.5,
5.1, 1219, 2.5,
3.4, 1219, 2.5,
5.1, 1219, 2.5,
4.3, 1219, 2.5,
3.87, 1249, 2.5,
3.89, 1249, 2.5,
6.4, 1249, 3.5,
7.5, 1249, 3.5,
6.6, 1249, 3.5,
3.63, 1249, 2.5,
11.7, 1249, 4.5,
8.4, 1249, 4.5,
8.2, 1249, 3.5,
8.8, 1249, 4.5,
8.3, 1249, 3.5,
2.35, 1249, 2.5,
4.1, 1249, 3.5,
6.2, 1249, 1.75,
7.2, 1249, 3.5,
5.6, 1249, 3.5,
4.7, 1249, 3.5,
6.6, 1249, 3.5,
6, 1249, 3.5,
4.53, 1249, 3.5,
7.4, 1249, 4.5,
11.4, 1249, 2.5,
7.7, 1249, 3.5,
7.8, 1249, 4.5,
3.48, 1249, 2.5,
14.8, 1249, 6.5,
18.8, 1249, 5.5,
6.3, 1249, 3.5,
3.54, 1249, 2.5,
1.15, 1249, 1.75,
3.1, 1249, 3.5,
7.2, 1279, 4.5,
4.4, 1279, 2.5,
10, 1279, 5.5,
12.9, 1279, 4.5,
1.49, 1279, 2.5,
13.3, 1279, 5.5,
9.8, 1279, 4.5,
3.8, 1279, 2.5,
8.9, 1279, 4.5,
3.463, 1279, 1.75,
6.4, 1279, 4.5,
9, 1279, 5.5,
9.1, 1279, 3.5,
3.621, 1279, 1.75,
5.9, 1279, 3.5,
8, 1279, 4.5,
9.6, 1279, 4.5,
21.3, 1245, 7.5,
4, 1245, 2.5,
1.1, 1245, 1.75,
1.2, 1245, 1.75,
1.5, 1245, 1.75,
2, 1245, 1.75,
3.925, 1245, 2.5,
7, 1245, 3.5,
1.8, 1245, 1.75,
2.2, 1245, 2.5,
17.2, 1245, 4.5,
3.7, 1245, 2.5,
1.3, 1245, 1.75,
3.9, 1245, 2.5,
18.8, 1245, 4.5,
0.9, 1245, 1.75,
1.3, 1245, 1.75,
0.45, 1245, 1.75,
19.3, 1245, 8.5,
20.7, 1245, 7.5,
3.5, 1245, 2.5,
2, 1245, 1.75,
4, 1245, 2.5,
2.2, 1245, 2.5,
2.6, 1245, 2.5,
2.4, 1245, 2.5,
8.2, 1245, 3.5,
17.3, 1245, 7.5,
3.8, 1245, 3.5,
5, 1275, 3.5,
5.4, 1275, 4.5,
2.7, 1275, 2.5,
11.7, 1275, 4.5,
11.4, 1275, 4.5,
9.3, 1275, 4.5,
11.8, 1275, 5.5,
9.3, 1275, 4.5,
2.5, 1275, 2.5,
9.7, 1275, 4.5,
5.1, 1275, 4.5,
6.7, 1275, 4.5,
1.7, 1275, 1.75,
4.6, 1275, 2.5,
10.4, 1275, 4.5,
4.5, 1275, 2.5,
7.3, 1275, 4.5,
4.2, 1275, 3.5,
8, 1275, 3.5,
2.6, 1275, 3.5,
3.7, 1275, 2.5,
4, 1275, 2.5,
7.8, 1275, 3.5,
11.1, 1275, 5.5,
1.6, 1275, 2.5,
6.2, 1275, 4.5,
3.7, 1275, 3.5,
8.2, 1275, 4.5,
1.6, 1275, 1.75,
3.1, 1275, 1.75,
22.3, 1275, 7.5,
7.6, 1275, 3.5,
1.2, 1275, 1.75,
8.7, 1275, 4.5,
1.9, 1275, 2.5,
12.4, 1305, 5.5,
7.2, 1305, 4.5,
14.5, 1305, 5.5,
7.2, 1305, 3.5,
14.7, 1305, 5.5,
2.7, 1305, 2.5,
7.7, 1305, 5.5,
6, 1305, 4.5,
12.7, 1305, 5.5,
5.7, 1305, 4.5,
6.6, 1305, 5.5,
3.7, 1305, 3.5,
12.4, 1305, 5.5,
2.7, 1305, 2.5,
6.6, 1305, 4.5,
6.1, 1305, 4.5,
3.8, 1305, 4.5,
4.1, 1305, 3.5,
1.1, 1305, 1.75,
4, 1305, 3.5,
7.4, 1305, 4.5,
4.4, 1305, 3.5,
3.3, 1305, 3.5,
5, 1305, 3.5,
7.8, 1305, 4.5,
1.7, 1305, 2.5,
6.4, 1305, 4.5,
1, 1305, 1.75,
7.2, 1305, 4.5,
8.4, 1305, 4.5,
1.2, 1305, 1.75,
7, 1305, 3.5,
5.7, 1305, 3.5,
2.3, 1305, 2.5,
10.1, 1305, 4.5,
5.9, 1305, 3.5,
9.2, 1305, 4.5,
5.9, 1305, 4.5,
7.6, 1305, 4.5,
4.8, 1305, 2.5,
5.7, 1305, 4.5,
4.2, 1305, 2.5,
1.4, 1305, 1.75,
3.9, 1305, 3.5,
6.5, 1305, 4.5,
6.2, 1305, 4.5,
3.8, 1305, 3.5,
2.5, 1305, 3.5,
5.1, 1305, 3.5,
3.9, 1305, 2.5,
1.9, 1305, 2.5,
7.9, 1305, 4.5,
3.9, 1305, 2.5,
4.7, 1305, 4.5,
9.4, 1305, 4.5,
4.6, 1305, 3.5,
9.1, 1305, 4.5,
8.6, 1305, 4.5,
6.4, 1305, 4.5,
5.6, 1305, 3.5,
8.8, 1305, 3.5,
8.5, 1305, 3.5,
7.2, 1305, 4.5,
7.2, 1305, 2.5,
2, 1335, 2.5,
15.5, 1335, 8.5,
12.3, 1335, 1.75,
7.3, 1335, 4.5,
1.7, 1335, 1.75,
2.4, 1335, 2.5,
2.1, 1335, 2.5,
4.9, 1335, 3.5,
2.1, 1335, 2.5,
3.3, 1335, 2.5,
1.6, 1335, 2.5,
8.9, 1335, 4.5,
2.6, 1335, 2.5,
3.4, 1335, 3.5,
5.6, 1335, 3.5,
8.7, 1335, 4.5,
1.2, 1335, 1.75,
1.7, 1335, 2.5,
1.1, 1335, 2.5,
2.9, 1335, 2.5,
3.3, 1335, 1.75,
5.3, 1335, 3.5,
4.4, 1335, 3.5,
4.9, 1335, 4.5,
6.5, 1335, 4.5,
5.8, 1335, 3.5,
2, 1335, 2.5,
0.8, 1335, 1.75,
2.7, 1335, 2.5,
2.3, 1335, 2.5,
9.5, 1335, 5.5,
2.1, 1335, 2.5,
4.9, 1335, 3.5,
6.8, 1335, 4.5,
7.4, 1335, 4.5,
6.7, 1335, 4.5,
6.2, 1335, 4.5,
13.4, 1335, 4.5,
9.4, 1335, 5.5,
8.3, 1335, 4.5,
4.3, 1335, 3.5,
7.3, 1335, 3.5,
2.7, 1335, 2.5,
5.2, 1335, 4.5,
4.1, 1335, 3.5,
6, 1335, 4.5,
15.5, 1335, 6.5,
2, 1335, 2.5,
1.3, 1335, 2.5,
3.2, 1335, 2.5,
10.9, 1335, 5.5,
4.8, 1335, 3.5,
5.8, 1335, 4.5,
3.2, 1335, 2.5,
5.201, 1365, 2.5,
13.7, 1365, 6.5,
8.9, 1365, 4.5,
6.1, 1365, 2.5,
9, 1365, 3.5,
5.2, 1365, 3.5,
7.8, 1365, 4.5,
11.6, 1365, 4.5,
12.1, 1365, 4.5,
8.4, 1365, 4.5,
11.4, 1365, 4.5,
9.2, 1365, 4.5,
10.1, 1365, 4.5,
2.9, 1365, 1.75,
9.6, 1365, 4.5,
7.6, 1365, 2.5,
5.3, 1365, 3.5,
6.4, 1365, 3.5,
7.4, 1365, 3.5,
15.1, 1365, 5.5,
5.2, 1365, 4.5,
6.2, 1365, 3.5,
8.4, 1365, 4.5,
5.7, 1365, 3.5,
8.5, 1235, 3.5,
0.97, 1235, 1.75,
2.1674, 1235, 1.75,
10.1, 1235, 2.5,
14.2, 1235, 5.5,
3.9, 1235, 2.5,
6.7, 1235, 3.5,
2.8, 1235, 2.5,
2.7, 1235, 2.5,
3.6, 1235, 2.5,
3, 1235, 2.5,
3.5, 1235, 2.5,
3.384, 1235, 2.5,
19.5, 1265, 8.5,
19.6, 1265, 7.5,
9.9, 1265, 4.5,
6.4, 1265, 3.5,
11.9, 1265, 5.5,
9.5, 1265, 4.5,
10.2, 1265, 5.5,
12.5, 1265, 6.5,
8.8, 1265, 5.5,
10.7, 1265, 4.5,
15, 1265, 5.5,
13.3, 1265, 5.5,
8.3, 1265, 4.5,
5.2, 1265, 3.5,
2.5, 1265, 1.75,
12.5, 1265, 5.5,
6.3, 1265, 4.5,
9.2, 1265, 4.5,
3.3, 1265, 2.5,
2.5, 1265, 1.75,
9.9, 1265, 4.5,
7.1, 1265, 5.5,
2.3, 1295, 1.75,
6.1, 1295, 2.5,
2.2, 1295, 1.75,
2.12, 1295, 1.75,
21.2, 1295, 5.5,
2.278, 1295, 1.75,
2.199, 1295, 1.75,
1.6065, 1295, 1.75,
1.725, 1295, 1.75,
3.226, 1295, 1.75,
2.12, 1295, 1.75,
2.752, 1295, 1.75,
2.8, 1295, 2.5,
2.278, 1295, 1.75,
6.9, 1295, 3.5,
7.1, 1295, 3.5,
11, 1295, 4.5,
2.2, 1295, 1.75,
18.4, 1295, 5.5,
5.7, 1295, 2.5,
8.5, 1325, 4.5,
6.2, 1325, 4.5,
6.2, 1325, 4.5,
11.2, 1325, 5.5,
12.2, 1325, 5.5,
5.9, 1325, 4.5,
4.8, 1325, 3.5,
11.1, 1325, 6.5,
2.8073, 1325, 2.5,
2.0015, 1325, 1.75,
9.1, 1325, 4.5,
6.4, 1325, 3.5,
5.1, 1325, 3.5,
10.9, 1325, 6.5,
8.2, 1325, 5.5,
6.3, 1325, 5.5,
8.4, 1325, 5.5,
3.6, 1325, 2.5,
8.1, 1325, 5.5,
7.1, 1325, 5.5,
2.3175, 1325, 1.75,
9.7, 1325, 6.5,
10.5, 1325, 5.5,
14.7, 1325, 6.5,
7.9, 1325, 5.5,
13.2, 1325, 6.5,
3.6, 1325, 3.5,
3.5, 1325, 2.5,
8.9, 1325, 5.5,
6.2, 1325, 2.5,
4.7, 1355, 2.5,
4.2, 1355, 2.5,
2.1, 1355, 1.75,
5.7, 1355, 2.5,
4.1, 1355, 2.5,
7.5, 1355, 2.5,
4.9, 1355, 2.5,
3.2, 1355, 2.5,
2.7, 1355, 1.75,
3.4, 1355, 1.75,
2.5, 1355, 1.75,
3.6, 1355, 2.5,
8, 1355, 2.5,
2, 1355, 1.75,
4, 1355, 2.5,
2.8, 1355, 1.75,
6.1, 1355, 3.5,
2.278, 1355, 2.5,
2.4, 1355, 2.5,
12.5, 1355, 4.5,
2.4, 1355, 1.75,
3.1, 1355, 2.5,
3.9, 1355, 2.5,
3.4, 1355, 2.5,
2.436, 1355, 1.75,
4.6, 1355, 2.5,
5.5, 1355, 2.5,
12.5, 1355, 2.5,
15, 1355, 3.5,
2.6, 1355, 1.75,
17.2, 1355, 1.75,
8.6, 1205, 5.5,
11.2, 1205, 5.5,
6.6, 1205, 5.5,
5.6, 1205, 4.5,
5, 1205, 3.5,
9, 1205, 5.5,
4.8, 1205, 4.5,
5.2, 1205, 2.5,
15.6, 1205, 6.5,
10.1, 1205, 6.5,
2.5308, 1205, 2.5,
5.5, 1205, 4.5,
11.3, 1205, 6.5,
5.9, 1205, 4.5,
6.7, 1205, 5.5,
6.1, 1205, 5.5,
4.9, 1205, 4.5,
12.2, 1205, 7.5,
11.9, 1205, 6.5,
6.5, 1205, 4.5,
6.1, 1205, 5.5,
6.1, 1205, 5.5,
6.3, 1205, 4.5,
9.3, 1205, 6.5,
10.1, 1205, 5.5,
4.1, 1205, 4.5,
6.7, 1205, 5.5,
10, 1205, 4.5,
9.4, 1205, 5.5,
6.8, 1205, 5.5,
13.2, 1205, 6.5,
7, 1205, 4.5,
14.1, 1205, 7.5,
15.5, 1235, 7.5,
13.9, 1235, 6.5,
12.9, 1235, 6.5,
6.7, 1235, 5.5,
17, 1235, 6.5,
12.1, 1235, 6.5,
9.6, 1235, 5.5,
12.8, 1235, 8.5,
11.9, 1235, 8.5,
18.8, 1235, 7.5,
3.7, 1235, 3.5,
10.2, 1235, 7.5,
16, 1235, 8.5,
7.8, 1268, 5.5,
9.3, 1268, 5.5,
6.2, 1268, 4.5,
3.7, 1268, 4.5,
5.6, 1268, 4.5,
4.4, 1268, 4.5,
5.7, 1268, 5.5,
9.6, 1268, 5.5,
7.3, 1268, 5.5,
8.2, 1268, 5.5,
4.7, 1268, 3.5,
3, 1268, 3.5,
8.6, 1268, 5.5,
7.6, 1268, 4.5,
9.5, 1268, 5.5,
1.646, 1268, 1.75,
5.9, 1268, 4.5,
5.6, 1268, 4.5,
6, 1268, 5.5,
7.1, 1268, 5.5,
11.4, 1268, 5.5,
7.1, 1268, 3.5,
10.2, 1268, 4.5,
6.4, 1268, 4.5,
4, 1268, 3.5,
4.3, 1268, 3.5,
3.7, 1268, 3.5,
7, 1268, 5.5,
11.3, 1268, 6.5,
7.2, 1268, 5.5,
10.7, 1268, 5.5,
5.8, 1268, 4.5,
3.2, 1268, 2.5,
8.9, 1268, 5.5,
12.7, 1268, 5.5,
7.5, 1268, 3.5,
4.3, 1268, 3.5,
3.1, 1268, 2.5,
7.2, 1268, 4.5,
7.4, 1268, 4.5,
12.1, 1268, 4.5,
8.7, 1268, 4.5,
4.4, 1268, 3.5,
8.6, 1268, 5.5,
11.5, 1268, 4.5,
2.436, 1295, 1.75,
3.925, 1295, 2.5,
12.8, 1295, 4.5,
3.7, 1295, 2.5,
7.9, 1295, 4.5,
2.278, 1295, 1.75,
3, 1295, 2.5,
4.8, 1295, 2.5,
4.5, 1295, 2.5,
12.4, 1295, 4.5,
5.5, 1295, 3.5,
12.2, 1295, 5.5,
4.095, 1295, 1.75,
6, 1295, 3.5,
5, 1295, 3.5,
6.1, 1295, 3.5,
4, 1295, 2.5,
3.7, 1295, 2.5,
8, 1295, 5.5,
2.515, 1295, 1.75,
21.3, 1295, 4.5,
3.3, 1295, 2.5,
8.7, 1295, 4.5,
1.725, 1295, 1.75,
5.7, 1295, 3.5,
6.8, 1295, 4.5,
8.3, 1295, 4.5,
6.6, 1295, 4.5,
5.8, 1295, 3.5,
10.2, 1295, 4.5,
3.6, 1295, 2.5,
5, 1295, 4.5,
9.1, 1295, 4.5,
4.3, 1295, 3.5,
4.8, 1295, 3.5,
7.7, 1295, 3.5,
2.989, 1295, 1.75,
3.3, 1295, 2.5,
6.7, 1295, 3.5,
2.33125, 1295, 1.75,
6.7, 1325, 3.5,
7.4, 1325, 3.5,
8, 1325, 3.5,
3.779, 1325, 1.75,
10, 1325, 4.5,
9.3, 1325, 4.5,
5.3, 1325, 4.5,
2.65, 1325, 2.5,
3.35, 1325, 2.5,
5.4, 1325, 2.5,
4.1, 1325, 3.5,
4.5, 1325, 3.5,
5.6, 1325, 4.5,
2.3175, 1325, 2.5,
6.4, 1325, 3.5,
2.33125, 1325, 1.75,
2.33125, 1325, 1.75,
3.7, 1325, 3.5,
5.3, 1325, 3.5,
2.33125, 1325, 1.75,
2.33125, 1325, 1.75,
2.33125, 1325, 1.75,
5.5, 1325, 2.5,
2.8, 1325, 1.75,
4, 1325, 2.5,
2.357, 1325, 1.75,
2.12, 1325, 1.75,
2.436, 1325, 1.75,
9.9, 1325, 4.5,
9.4, 1325, 6.5,
2.0015, 1325, 1.75,
5.6, 1325, 3.5,
3.2, 1325, 2.5,
3.068, 1325, 1.75,
2.8, 1325, 2.5,
2.278, 1325, 1.75,
2.4, 1325, 3.5,
2.12, 1325, 2.5,
3.4, 1325, 3.5,
2.91, 1325, 1.75,
14.2, 1325, 7.5,
7.3, 1325, 3.5,
4.2, 1325, 2.5,
6.8, 1325, 4.5,
5.7, 1355, 2.5,
8.8, 1355, 3.5,
7.4, 1355, 3.5,
5.3, 1355, 2.5,
5.6, 1355, 2.5,
19.3, 1355, 2.5,
5.7, 1355, 3.5,
6.8, 1355, 3.5,
6.8, 1355, 1.75,
3.4, 1355, 2.5,
4.1, 1355, 2.5,
8.9, 1355, 2.5,
4.5, 1355, 2.5,
3, 1355, 2.5,
2.594, 1355, 1.75,
2.6, 1355, 1.75,
13, 1355, 4.5,
7.2, 1355, 1.75
]);
var buf133 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf133);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc133 = gl.getUniformLocation(prog133,"mvMatrix");
var prMatLoc133 = gl.getUniformLocation(prog133,"prMatrix");
// ****** points object 134 ******
var prog134  = gl.createProgram();
gl.attachShader(prog134, getShader( gl, "unnamed_chunk_4vshader134" ));
gl.attachShader(prog134, getShader( gl, "unnamed_chunk_4fshader134" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog134, 0, "aPos");
gl.bindAttribLocation(prog134, 1, "aCol");
gl.linkProgram(prog134);
var v=new Float32Array([
6.2, 1239, 5.5,
2.07, 1239, 2.5,
2.55, 1239, 1.75,
6.1, 1239, 4.5,
1.6, 1239, 1.75,
9.4, 1239, 6.5,
4.7, 1239, 4.5,
2.9, 1239, 1.75,
6.3, 1239, 5.5,
1.91, 1239, 2.5,
10.7, 1239, 8.5,
2.31, 1239, 1.75,
4.8, 1239, 4.5,
1.51, 1239, 1.75,
3.3, 1239, 1.75,
8.9, 1239, 7.5,
2.79, 1239, 1.75,
3.5, 1239, 4.5,
8.2, 1239, 5.5,
3.5, 1239, 3.5,
2.71, 1239, 2.5,
3.2, 1239, 3.5,
2.1, 1239, 2.5,
2.3, 1239, 2.5,
0.5, 1239, 1.75,
11.2, 1239, 6.5,
8.3, 1239, 6.5,
6.9, 1239, 4.5,
10.3, 1239, 8.5,
10, 1239, 6.5,
6.6, 1239, 5.5,
8.7, 1239, 6.5,
10.4, 1239, 7.5,
7.1, 1239, 3.5,
12.3, 1239, 9.5,
7.2, 1239, 6.5,
7.3, 1239, 6.5,
9.6, 1239, 9.5,
9.8, 1239, 7.5,
1.8, 1239, 1.75,
3.9, 1239, 3.5,
7.1, 1269, 5.5,
2.95, 1269, 1.75,
10, 1269, 4.5,
4.3, 1269, 2.5,
3.6, 1269, 2.5,
7, 1269, 5.5,
3.3, 1269, 2.5,
6.23, 1269, 1.75,
5.2, 1269, 2.5,
18.2, 1269, 7.5,
3.5, 1269, 2.5,
13, 1269, 6.5,
3.1, 1269, 2.5,
8.2, 1269, 6.5,
10.3, 1269, 5.5,
13.1, 1269, 8.5,
5.3, 1269, 4.5,
8.7, 1269, 6.5,
9.3, 1269, 5.5,
2.87, 1269, 1.75,
3.59, 1269, 2.5,
11.5, 1269, 9.5,
3.1, 1269, 2.5,
4.3, 1269, 1.75,
5.4, 1269, 3.5,
10.6, 1269, 6.5,
5.4, 1269, 5.5,
7.1, 1269, 5.5,
10.2, 1269, 6.5,
11, 1269, 4.5,
3.2, 1269, 2.5,
7.5, 1269, 5.5,
11.4, 1269, 7.5,
8.2, 1269, 7.5,
4.6, 1269, 4.5,
2.79, 1269, 2.5,
3.1, 1269, 2.5,
8.7, 1299, 4.5,
19.1, 1299, 5.5,
14.8, 1299, 6.5,
8.5, 1299, 4.5,
10, 1299, 6.5,
17.5, 1299, 9.5,
16.2, 1299, 8.5,
8.3, 1299, 6.5,
4.6, 1299, 2.5,
4.7, 1299, 3.5,
5.8, 1299, 3.5,
9.4, 1299, 3.5,
5.2, 1299, 3.5,
12.1, 1299, 5.5,
8.4, 1299, 2.5,
2.3, 1299, 2.5,
4.6, 1329, 3.5,
18.7, 1329, 5.5,
13.4, 1329, 2.5,
9.2, 1329, 4.5,
5, 1329, 3.5,
8.2, 1329, 4.5,
3.91, 1329, 3.5,
3.2, 1329, 1.75,
4.3, 1329, 2.5,
14.9, 1329, 5.5,
3.67, 1329, 1.75,
9, 1329, 2.5,
17.2, 1329, 3.5,
1.6, 1329, 1.75,
1.9, 1329, 3.5,
3.67, 1329, 2.5,
6.6, 1329, 3.5,
7.8, 1329, 4.5,
5.1, 1329, 3.5,
7.9, 1329, 6.5,
6.3, 1329, 3.5,
10, 1329, 2.5,
5.6, 1329, 5.5,
4.9, 1329, 4.5,
4.1, 1329, 2.5,
6.39, 1329, 2.5,
5.8, 1329, 3.5,
4.6, 1329, 3.5,
7.7, 1329, 3.5,
23, 1329, 9.5,
2.39, 1329, 3.5,
2, 1329, 1.75,
5.9, 1329, 3.5,
8.1, 1329, 3.5,
5.2, 1329, 3.5,
5.7, 1329, 4.5,
3.11, 1329, 3.5,
2.63, 1329, 1.75,
8.3, 1360, 2.5,
6.6, 1360, 2.5,
4.07, 1360, 1.75,
7, 1360, 1.75,
4.5, 1360, 2.5,
1.9, 1360, 1.75,
3.99, 1360, 1.75,
3.51, 1360, 2.25,
4.7, 1360, 2.25,
6.3, 1360, 2.5,
3.75, 1360, 1.75,
0.71, 1360, 1.75,
6.9, 1360, 2.5,
4.4, 1360, 2.25,
5, 1360, 2.5,
4.95, 1360, 1.75,
5.7, 1360, 2.5,
3.91, 1360, 1.75,
3.35, 1360, 1.75,
19.2, 1240, 12.5,
5.1, 1240, 3.5,
9, 1240, 9.5,
3.9, 1240, 3.5,
3.9, 1240, 4.5,
2.9, 1240, 1.75,
16.2, 1240, 10.5,
12.2, 1240, 10.5,
17.8, 1240, 11.5,
5.1, 1240, 3.5,
10.8, 1240, 8.5,
4, 1240, 3.5,
5, 1240, 3.5,
15.2, 1240, 10.5,
19.7, 1240, 9.5,
6.5, 1240, 5.5,
9.1, 1240, 7.5,
12, 1240, 10.5,
15.2, 1240, 11.5,
3, 1240, 2.5,
6.4, 1271, 4.5,
4.9, 1271, 3.5,
18.4, 1271, 10.5,
9.1, 1271, 6.5,
2.3, 1271, 1.75,
6, 1271, 3.5,
4.5, 1271, 3.5,
13.9, 1271, 9.5,
5.4, 1271, 3.5,
8.8, 1271, 5.5,
4.4, 1271, 3.5,
19.6, 1271, 10.5,
17.1, 1271, 10.5,
9.7, 1271, 5.5,
5.8, 1271, 3.5,
7.4, 1271, 3.5,
12.1, 1302, 3.5,
7.9, 1302, 3.5,
5.5, 1302, 3.5,
11.7, 1302, 4.5,
2.71, 1302, 1.75,
12, 1302, 5.5,
10.8, 1302, 3.5,
14, 1302, 5.5,
13.1, 1302, 2.5,
9.3, 1302, 5.5,
6.2, 1302, 4.5,
4.9, 1302, 2.5,
19.1, 1302, 5.5,
9.6, 1302, 5.5,
6, 1302, 2.5,
8.7, 1302, 6.5,
7, 1302, 3.5,
2.31, 1302, 3.5,
9.7, 1302, 5.5,
4.2, 1302, 3.5,
6.7, 1302, 4.5,
3.11, 1332, 1.75,
6.2, 1332, 3.5,
20, 1332, 8.5,
11.1, 1332, 4.5,
13.5, 1332, 6.5,
7.6, 1332, 3.5,
20.2, 1332, 5.5,
8, 1332, 3.5,
25.1, 1332, 12.5,
6, 1332, 3.5,
3.7, 1332, 2.5,
4.9, 1332, 2.5,
4.95, 1332, 1.75,
7.7, 1231, 7.5,
10.4, 1231, 9.5,
6.2, 1231, 7.5,
6.6, 1231, 7.5,
10.5, 1231, 8.5,
10.1, 1231, 8.5,
3.1, 1231, 2.5,
3.7, 1231, 2.5,
2.7, 1231, 2.5,
5.6, 1231, 5.5,
9.6, 1231, 6.5,
6.5, 1231, 5.5,
5.8, 1231, 6.5,
6.2, 1231, 6.5,
5.9, 1231, 6.5,
6, 1231, 6.5,
5.2, 1231, 5.5,
3.1, 1231, 2.5,
3.2, 1231, 3.5,
4.1, 1231, 3.5,
8.1, 1231, 7.5,
3.8, 1231, 2.5,
1.59, 1231, 1.75,
2.63, 1231, 2.5,
1.35, 1231, 1.75,
2.8, 1231, 2.5,
3.4, 1231, 5.5,
4, 1231, 4.5,
2.31, 1231, 3.5,
6.6, 1231, 5.5,
3.6, 1231, 3.5,
6.2, 1231, 4.5,
8.4, 1231, 7.5,
5, 1231, 5.5,
3.2, 1231, 2.5,
5.7, 1231, 5.5,
13.8, 1231, 7.5,
5.9, 1231, 4.5,
8.1, 1231, 5.5,
3.6, 1231, 3.5,
7.4, 1231, 6.5,
10.8, 1231, 8.5,
9.8, 1231, 8.5,
5.1, 1231, 4.5,
4.3, 1231, 4.5,
6.7, 1231, 5.5,
7.1, 1231, 7.5,
9.2, 1261, 4.5,
8.4, 1261, 4.5,
32.1, 1261, 11.5,
17.6, 1261, 10.5,
21.5, 1261, 9.5,
22.2, 1261, 10.5,
3.4, 1320, 2.5,
17.3, 1320, 5.5,
14.5, 1320, 4.5,
7.1, 1320, 4.5,
5.3, 1320, 3.5,
17.1, 1320, 8.5,
3.7, 1320, 2.5,
15.5, 1320, 7.5,
22.4, 1320, 8.5,
17.3, 1321, 10.5,
4.5, 1321, 2.5,
7.5, 1321, 4.5,
8.7, 1321, 4.5,
8.1, 1321, 4.5,
13.9, 1321, 8.5,
5.9, 1321, 2.5,
9.1, 1321, 5.5,
22.6, 1321, 7.5,
15.1, 1321, 6.5,
3.7, 1321, 2.5,
7.1, 1321, 3.5,
5.7, 1321, 2.5,
14, 1321, 7.5,
2.87, 1321, 1.75,
2.8, 1351, 1.75,
8.2, 1351, 3.5,
13.2, 1351, 5.5,
7.7, 1351, 4.5,
3, 1351, 2.5,
5.4, 1351, 2.5,
5.3, 1351, 3.5,
2.63, 1351, 1.75,
10.1, 1351, 4.5,
7.8, 1351, 5.5,
8, 1351, 3.5,
8.5, 1351, 3.5,
3, 1351, 1.75,
7.6, 1351, 5.5,
5.8, 1351, 2.5,
8, 1351, 5.5,
7.3, 1351, 5.5,
11.7, 1351, 5.5,
2.8, 1351, 1.75,
6.1, 1351, 3.5,
3.7, 1351, 2.5,
5.5, 1351, 2.5,
5.5, 1351, 3.5,
11.9, 1351, 8.5,
7.1, 1351, 5.5,
6.4, 1351, 3.5,
9.5, 1351, 5.5,
4.4, 1351, 1.75,
4, 1351, 1.75,
8, 1351, 3.5,
14.5, 1351, 4.5,
3.8, 1351, 3.5,
5.1, 1351, 3.5,
9.1, 1351, 6.5,
2.6, 1351, 1.75,
4, 1351, 2.5,
8.8, 1351, 6.5,
9.5, 1351, 1.75,
9.6, 1351, 2.5,
10, 1351, 6.5,
7.7, 1351, 2.5,
6, 1351, 4.5,
3.9, 1351, 1.75,
8.2, 1351, 5.5,
9, 1351, 5.5,
4.2, 1351, 1.75,
6.5, 1351, 3.5,
3.9, 1351, 1.75,
3.4, 1351, 2.5,
2.6, 1351, 1.75,
9.1, 1351, 5.5,
6.5, 1310, 4.5,
6.5, 1310, 3.5,
7.2, 1310, 5.5,
4, 1310, 4.5,
8.5, 1310, 5.5,
8.3, 1310, 4.5,
11.4, 1310, 5.5,
11.6, 1310, 7.5,
2.31, 1310, 1.75,
11.1, 1310, 7.5,
8.1, 1310, 4.5,
9.1, 1310, 5.5,
13.485, 1310, 5.5,
2.7, 1310, 2.5,
8.7, 1310, 3.5,
9.1, 1310, 7.5,
11.1, 1310, 3.5,
6.2, 1310, 4.5,
10.1, 1310, 5.5,
3.9, 1310, 3.5,
11.6, 1310, 6.5,
10.4, 1310, 5.5,
9, 1310, 5.5,
2.07, 1310, 2.5,
5.5, 1310, 3.5,
6.4, 1310, 4.5,
5.8, 1310, 4.5,
7.2, 1310, 4.5,
7, 1310, 5.5,
1.83, 1310, 1.75,
8.8, 1310, 5.5,
14.4, 1310, 7.5,
14.7, 1310, 7.5,
6.5, 1310, 4.5,
4.9, 1310, 4.5,
6.9, 1310, 4.5,
10.7, 1310, 7.5,
2.2, 1310, 2.5,
10.8, 1310, 7.5,
3, 1310, 2.5,
3.9, 1310, 2.5,
6, 1310, 4.5,
8.7, 1310, 5.5,
6.6, 1310, 4.5,
5, 1310, 3.5,
6.9, 1310, 4.5,
10.4, 1310, 7.5,
7.3, 1310, 6.5,
7.1, 1310, 6.5,
5.6, 1310, 5.5,
10.9, 1310, 7.5,
4.2, 1310, 3.5,
4.4, 1310, 3.5,
13, 1310, 5.5,
9.9, 1310, 7.5,
7.8, 1310, 5.5,
8.4, 1310, 4.5,
19.8, 1400, 8.5,
15.8, 1400, 6.5,
16.8, 1400, 4.5,
6.6, 1400, 5.5,
10.6, 1400, 6.5,
10.5, 1400, 8.5,
8.2, 1400, 7.5,
11.2, 1400, 8.5,
15.1, 1400, 7.5,
13.1, 1400, 7.5,
6.4, 1400, 2.5,
9, 1400, 8.5,
16.1, 1400, 7.5,
15.5, 1400, 2.5,
12.5, 1400, 4.5,
9.1, 1400, 5.5,
12, 1400, 6.5,
16.7, 1400, 6.5,
3.7, 1400, 2.5,
13.3, 1400, 7.5,
11, 1400, 6.5,
9.5, 1400, 2.5,
7.8, 1400, 5.5,
8.5, 1400, 5.5,
4.6, 1400, 2.5,
11.1, 1400, 7.5,
10.7, 1400, 6.5,
7.1, 1400, 2.5,
7.4, 1400, 6.5,
4.2, 1400, 2.5,
12.5, 1400, 5.5,
5.8, 1400, 5.5,
5.7, 1189, 3.5,
11.7, 1189, 5.5,
9.5, 1189, 6.5,
9.9, 1189, 4.5,
11.1, 1189, 6.5,
9, 1189, 4.5,
8.2, 1189, 5.5,
3.5, 1189, 3.5,
9.2, 1189, 7.5,
5.7, 1189, 4.5,
5.1, 1189, 3.5,
2.6, 1189, 2.5,
9.1, 1189, 5.5,
5.6, 1189, 6.5,
10.1, 1189, 6.5,
7, 1189, 6.5,
3.2, 1189, 2.5,
4.3, 1189, 3.5,
7.8, 1189, 4.5,
4.3, 1189, 3.5,
3, 1189, 2.5,
3.9, 1189, 4.5,
4.6, 1189, 3.5,
3.2, 1189, 3.5,
7.5, 1189, 5.5,
7, 1189, 5.5,
4.3, 1189, 3.5,
5.1, 1189, 3.5,
8.1, 1189, 4.5,
9.6, 1189, 7.5,
3.6, 1189, 3.5,
3.8, 1189, 3.5,
7.4, 1189, 6.5,
9.8, 1189, 3.5,
9.1, 1189, 5.5,
7.5, 1189, 4.5,
8.3, 1189, 4.5,
7.7, 1189, 5.5,
7, 1189, 4.5,
7.8, 1189, 5.5,
10.9, 1189, 6.5,
10, 1189, 5.5,
7, 1189, 5.5,
10.9, 1189, 6.5,
8.5, 1189, 4.5,
4.8, 1189, 3.5,
2.3, 1189, 1.75,
6.3, 1189, 5.5,
5.3, 1189, 4.5,
4.7, 1189, 2.5,
7.7, 1189, 6.5,
3.5, 1189, 1.75,
4, 1189, 4.5,
6.9, 1189, 5.5,
4.4, 1189, 5.5,
3.6, 1219, 2.5,
3.6, 1219, 2.5,
2.87, 1219, 1.75,
6.6, 1219, 3.5,
8.4, 1219, 4.5,
4.1, 1219, 1.75,
4.6, 1219, 1.75,
9.7, 1219, 2.5,
3.2, 1219, 2.5,
4.2, 1219, 1.75,
5.3, 1219, 3.5,
2.23, 1219, 1.75,
4.3, 1219, 3.5,
6, 1219, 2.5,
8.7, 1219, 3.5,
4.3, 1219, 2.5,
4.8, 1219, 1.75,
2.23, 1219, 1.75,
3.7, 1219, 1.75,
5.3, 1219, 2.5,
3.2, 1219, 1.75,
4.3, 1249, 3.5,
5.6, 1249, 2.5,
7.1, 1249, 5.5,
12.5, 1249, 8.5,
8.6, 1249, 5.5,
9.5, 1249, 8.5,
9.6, 1249, 8.5,
3, 1249, 1.75,
3.4, 1249, 2.5,
6, 1249, 2.5,
2.6, 1249, 1.75,
6.2, 1249, 3.5,
2.7, 1249, 1.75,
2.3, 1249, 1.75,
2.31, 1249, 1.75,
7.9, 1249, 7.5,
6.1, 1249, 7.5,
2.1, 1249, 1.75,
3.51, 1249, 1.75,
7.2, 1249, 3.5,
5.1, 1249, 1.75,
10.5, 1249, 11.5,
11.9, 1249, 4.5,
8.5, 1249, 8.5,
15.5, 1249, 9.5,
3.5, 1249, 1.75,
21.4, 1249, 11.5,
4.2, 1249, 3.5,
4.6, 1249, 3.5,
4.9, 1249, 3.5,
2.07, 1279, 1.75,
7.8, 1279, 4,
9.2, 1279, 8.5,
13.7, 1279, 10.5,
18.7, 1279, 11.5,
4.1, 1279, 3.5,
3.2, 1279, 2.5,
15.5, 1279, 10.5,
10.8, 1279, 6.5,
3.6, 1279, 1.75,
10.1, 1279, 6.5,
3, 1279, 2.5,
11.4, 1279, 9.5,
11.5, 1279, 8.5,
10.7, 1279, 9.5,
4.1, 1279, 1.75,
7, 1279, 9.5,
10.3, 1279, 10.5,
11.3, 1279, 8.5,
7.7, 1279, 4.5,
23.3, 1245, 11.5,
5.3, 1245, 3.5,
2.71, 1245, 2.5,
3.03, 1245, 2.5,
2.55, 1245, 2.5,
3.5, 1245, 2.5,
2.8, 1245, 1.75,
3.1, 1245, 2.5,
7.6, 1245, 4.5,
2, 1245, 2.5,
19, 1245, 7.5,
4.4, 1245, 2.5,
2.63, 1245, 1.75,
27.6, 1245, 13.5,
20.9, 1245, 8.5,
2.8, 1245, 2.5,
3.2, 1245, 2.5,
4.5, 1245, 2.5,
2.23, 1245, 2.5,
4.6, 1245, 3.5,
5.8, 1245, 3.5,
9.4, 1245, 4.5,
18.5, 1245, 10.5,
4.9, 1245, 2.5,
1.67, 1245, 1.75,
2.8, 1245, 1.75,
3, 1245, 2.5,
3.59, 1245, 3.5,
2.63, 1245, 1.75,
3.4, 1245, 2.5,
5.2, 1275, 4.5,
14.2, 1275, 10.5,
14.8, 1275, 10.5,
11.8, 1275, 9.5,
14.1, 1275, 5.5,
13.2, 1275, 7.5,
5.5, 1275, 2.5,
1.83, 1275, 1.75,
13, 1275, 6.5,
5.7, 1275, 6.5,
8.5, 1275, 7.5,
5.6, 1275, 5.5,
12.7, 1275, 8.5,
9.3, 1275, 8.5,
10.1, 1275, 8.5,
4.4, 1275, 3.5,
4.2, 1275, 3.5,
9.4, 1275, 9.5,
14.7, 1275, 10.5,
8.9, 1275, 9.5,
11.7, 1275, 9.5,
23.2, 1275, 9.5,
8, 1275, 3.5,
11.2, 1275, 7.5,
14.7, 1305, 8.5,
8.6, 1305, 5.5,
16.3, 1305, 9.5,
17.9, 1305, 9.5,
10.2, 1305, 5.5,
6, 1305, 5.5,
17.8, 1305, 7.5,
6.4, 1305, 5.5,
8.1, 1305, 6.5,
15.1, 1305, 8.5,
8.5, 1305, 5.5,
7.7, 1305, 7.5,
4.5, 1305, 5.5,
8.8, 1305, 6.5,
5, 1305, 3.5,
5.3, 1305, 4.5,
10.2, 1305, 5.5,
2.39, 1305, 2.5,
8.1, 1305, 4.5,
9.2, 1305, 9.5,
9.1, 1305, 4.5,
6.8, 1305, 4.5,
11.7, 1305, 9.5,
6.7, 1305, 4.5,
11.4, 1305, 6.5,
8.9, 1305, 7.5,
6.3, 1305, 3.5,
6.6, 1305, 4.5,
7, 1305, 4.5,
1.91, 1305, 1.75,
6.6, 1305, 6.5,
5.1, 1305, 5.5,
9.4, 1305, 6.5,
12.4, 1305, 7.5,
12.2, 1305, 9.5,
6.6, 1305, 4.5,
12.5, 1305, 6.5,
10.5, 1305, 7.5,
10.2, 1305, 7.5,
9.5, 1305, 5.5,
9, 1305, 3.5,
10.5, 1305, 7.5,
8.4, 1305, 5.5,
1.43, 1305, 1.75,
5.5, 1335, 3.5,
18.5, 1335, 8.5,
10.8, 1335, 6.5,
2.39, 1335, 2.5,
5.2, 1335, 4.5,
3.5, 1335, 3.5,
7.7, 1335, 2.5,
4.8, 1335, 2.5,
6.5, 1335, 3.5,
3.4, 1335, 2.5,
1.75, 1335, 2.5,
9.9, 1335, 7.5,
3.1, 1335, 2.5,
10.9, 1335, 4.5,
3.9, 1335, 3.5,
13.4, 1335, 5.5,
2.47, 1335, 2.5,
3.8, 1335, 3.5,
1.99, 1335, 2.5,
5.2, 1335, 3.5,
6.3, 1335, 3.5,
8.7, 1335, 4.5,
7.2, 1335, 10.5,
8.9, 1335, 5.5,
9.2, 1335, 10.5,
7.9, 1335, 7.5,
2.4, 1335, 1.75,
11.6, 1335, 9.5,
9.1, 1335, 10.5,
10.1, 1335, 8.5,
7.8, 1335, 5.5,
17.7, 1335, 9.5,
11.1, 1335, 9.5,
9.8, 1335, 10.5,
4.6, 1335, 5.5,
8.7, 1335, 6.5,
6, 1335, 5.5,
4.8, 1335, 8.5,
8.2, 1335, 8.5,
17.7, 1335, 9.5,
3.03, 1335, 2.5,
3.8, 1335, 2.5,
3.9, 1335, 2.5,
13.9, 1335, 10.5,
8.5, 1335, 3.5,
2.15, 1335, 1.75,
9.9, 1335, 5.5,
6.3, 1335, 3.5,
2.23, 1335, 1.75,
5.2, 1335, 5.5,
14, 1365, 5.5,
3.8, 1365, 2.5,
3.1, 1365, 1.75,
15.5, 1365, 4.5,
13.2, 1365, 6.5,
7.2, 1365, 3.5,
10.3, 1365, 5.5,
7.1, 1365, 4.5,
10.8, 1365, 5.5,
14.9, 1365, 5.5,
14.2, 1365, 4.5,
10.2, 1365, 4.5,
13.2, 1365, 5.5,
9.8, 1365, 5.5,
11.8, 1365, 5.5,
4.2, 1365, 2.5,
11.4, 1365, 5.5,
7.1, 1365, 5.5,
9.2, 1365, 5.5,
9, 1365, 6.5,
20.2, 1365, 6.5,
9.6, 1365, 5.5,
8.8, 1365, 4.5,
27.2, 1365, 3.5,
11.7, 1365, 6.5,
9.5, 1365, 4.5,
5.9, 1365, 4.5,
1.91, 1365, 1.75,
4.2, 1365, 3.5,
2.39, 1365, 1.75,
2.3, 1365, 2.5,
4.7, 1365, 2.5,
10.9, 1235, 4.5,
5.8, 1235, 2.5,
3.8, 1235, 2.5,
3.9, 1235, 2.5,
2.47, 1235, 1.75,
3.2, 1235, 1.75,
15.2, 1235, 7.5,
6.9, 1235, 4.5,
2.23, 1235, 1.75,
11, 1235, 5.5,
6.5, 1235, 5.5,
7.6, 1235, 3.5,
8.3, 1235, 6.5,
8, 1235, 4.5,
6.9, 1235, 4.5,
3.4, 1235, 2.5,
3.1, 1235, 2.5,
2.31, 1235, 1.75,
2.07, 1235, 1.75,
3.43, 1235, 2.5,
2.15, 1235, 1.75,
3.3, 1235, 2.5,
5.1, 1235, 2.5,
3.11, 1235, 1.75,
2.07, 1235, 1.75,
5.1, 1235, 3.5,
5, 1235, 2.5,
1.67, 1235, 1.75,
8, 1235, 3.5,
2.87, 1235, 1.75,
3.27, 1235, 1.75,
21.6, 1265, 11.5,
21.5, 1265, 11.5,
10.1, 1265, 4.5,
13.7, 1265, 10.5,
9.7, 1265, 7.5,
15.1, 1265, 10.5,
9.4, 1265, 9.5,
13.1, 1265, 8.5,
16.5, 1265, 10.5,
14.1, 1265, 8.5,
14.4, 1265, 10.5,
11.3, 1265, 8.5,
1.75, 1295, 1.75,
2.23, 1295, 1.75,
1.67, 1295, 1.75,
3.9, 1295, 2.5,
1.11, 1295, 1.75,
1.99, 1295, 1.75,
4, 1295, 2.5,
9.1, 1295, 4.5,
4, 1295, 2.5,
4.2, 1295, 3.5,
21.9, 1295, 7.5,
1.67, 1295, 1.75,
1.67, 1295, 2.5,
2.47, 1295, 1.75,
3.43, 1295, 1.75,
3.6, 1295, 3.5,
3.5, 1295, 3.5,
3.2, 1295, 3.5,
3, 1295, 2.5,
1.43, 1295, 1.75,
3.4, 1295, 2.5,
2.15, 1295, 2.5,
3.5, 1295, 2.5,
6.5, 1295, 3.5,
2.47, 1295, 3.5,
4.9, 1295, 3.5,
3.6, 1295, 2.5,
5.2, 1295, 3.5,
7, 1295, 5.5,
4.5, 1295, 3.5,
10.6, 1295, 7.5,
2.23, 1295, 1.75,
9.5, 1295, 8.5,
13.4, 1295, 9.5,
7.2, 1295, 3.5,
3.11, 1295, 2.5,
3.11, 1295, 2.5,
4.7, 1295, 3.5,
3.6, 1295, 2.5,
1.75, 1295, 1.75,
3.8, 1295, 2.5,
2.47, 1295, 2.5,
20.9, 1295, 10.5,
2.4, 1295, 1.75,
10, 1295, 4.5,
3.2, 1325, 2.5,
9.7, 1325, 5.5,
6.6, 1325, 5.5,
7.1, 1325, 6.5,
12.6, 1325, 8.5,
13.5, 1325, 10.5,
6.6, 1325, 4.5,
5.4, 1325, 3.5,
12.3, 1325, 8.5,
4.1, 1325, 2.5,
12.4, 1325, 7.5,
8.2, 1325, 6.5,
13.1, 1325, 8.5,
10.3, 1325, 7.5,
6.9, 1325, 5.5,
9.4, 1325, 9.5,
3.6, 1325, 2.5,
9.6, 1325, 6.5,
12.5, 1325, 7.5,
15.9, 1325, 11.5,
11.9, 1325, 8.5,
3.4, 1355, 3.5,
1.99, 1355, 1.5,
1.35, 1355, 1.5,
1.51, 1355, 1.5,
1.99, 1355, 2,
2.6, 1355, 1.5,
5.7, 1355, 2.5,
2.3, 1355, 1.5,
2.07, 1355, 2.5,
9.9, 1355, 3.5,
1.35, 1355, 1.5,
1.91, 1355, 1.5,
8.6, 1355, 3.5,
11.4, 1355, 4.5,
2.1, 1355, 1.5,
3.03, 1355, 2.5,
3.9, 1355, 2.5,
7.2, 1355, 2.5,
5.1, 1355, 2.5,
5.5, 1355, 2.5,
3.1, 1355, 1.5,
1.83, 1355, 1.5,
5.9, 1355, 2.5,
4.1, 1355, 1.5,
3.9, 1355, 2.5,
4.3, 1355, 4,
9.1, 1355, 5,
2.4, 1355, 2.5,
2.47, 1355, 2,
4.4, 1355, 3,
3.2, 1355, 3,
2.23, 1355, 2,
13.9, 1355, 5,
2.31, 1355, 3,
4.9, 1355, 3.5,
1.91, 1355, 1.5,
5.3, 1355, 3.5,
7, 1355, 3.5,
6.1, 1355, 3.5,
5.3, 1355, 2.5,
4.1, 1355, 3.5,
7.9, 1355, 2.5,
4.3, 1355, 3,
4.3, 1355, 4,
8.8, 1355, 5,
2.4, 1355, 3,
2.8, 1355, 2,
15.2, 1355, 6,
15.9, 1355, 3.5,
5.4, 1355, 2.5,
2.71, 1355, 1.5,
17.6, 1355, 1.5,
9.8, 1205, 12.5,
6.9, 1205, 9.5,
9.5, 1205, 12.5,
5.8, 1205, 4.5,
16.9, 1205, 12.5,
11.1, 1205, 12.5,
6.1, 1205, 10.5,
14.5, 1205, 12.5,
7.6, 1205, 10.5,
6.2, 1205, 7.5,
3.19, 1205, 1.75,
6.5, 1205, 9.5,
5.2, 1205, 8.5,
13.5, 1205, 13.5,
6.4, 1205, 11.5,
7, 1205, 10.5,
10.1, 1205, 13.5,
12.7, 1205, 13.5,
7, 1205, 10.5,
11, 1205, 12.5,
15.3, 1205, 13.5,
9.3, 1205, 12.5,
16.3, 1205, 13.5,
16.8, 1235, 13.5,
14.7, 1235, 8.5,
13.5, 1235, 8.5,
9, 1235, 9.5,
18.6, 1235, 11.5,
13.2, 1235, 7.5,
11.5, 1235, 6.5,
2.23, 1235, 1.75,
20.6, 1235, 11.5,
14, 1235, 9.5,
12.2, 1235, 11.5,
21.4, 1235, 11.5,
4, 1235, 3.5,
11.4, 1235, 12.5,
18, 1235, 12.5,
2.31, 1235, 1.75,
9, 1268, 8.5,
10.8, 1268, 10.5,
7.4, 1268, 8.5,
6.3, 1268, 7.5,
10.5, 1268, 11.5,
7.7, 1268, 8.5,
8.5, 1268, 8.5,
11.6, 1268, 10.5,
11.8, 1268, 12.5,
6.4, 1268, 7.5,
7.9, 1268, 7.5,
13.1, 1268, 12.5,
11.3, 1268, 7.5,
7.7, 1268, 7.5,
14.5, 1268, 11.5,
7.9, 1268, 10.5,
11.6, 1268, 12.5,
6, 1268, 7.5,
11.5, 1268, 12.5,
16.2, 1268, 12.5,
3.2, 1268, 2.5,
8, 1268, 8.5,
8.3, 1268, 9.5,
14.4, 1268, 7.5,
10.9, 1268, 9.5,
4.8, 1268, 6.5,
9.2, 1268, 6.5,
13.4, 1268, 12.5,
4.5, 1295, 3.5,
15.6, 1295, 12.5,
10, 1295, 11.5,
2.7, 1295, 2.5,
3.3, 1295, 2.5,
6, 1295, 4.5,
15.2, 1295, 12.5,
3, 1295, 1.75,
14.1, 1295, 12.5,
9.2, 1295, 5.5,
6.2, 1295, 3.5,
7, 1295, 4.5,
3.3, 1295, 2.5,
10.5, 1295, 10.5,
6.3, 1295, 4.5,
1.59, 1295, 1.75,
8.8, 1295, 5.5,
6, 1295, 4.5,
12.8, 1295, 9.5,
9.9, 1295, 5.5,
5.2, 1295, 3.5,
9.4, 1295, 6.5,
4, 1295, 2.5,
7.2, 1295, 4.5,
8.1, 1325, 5.5,
8.3, 1325, 5.5,
8.8, 1325, 5.5,
10.4, 1325, 5.5,
10.2, 1325, 5.5,
5.6, 1325, 4.5,
4.1, 1325, 3.5,
6.6, 1325, 3.5,
4.7, 1325, 3.5,
5.5, 1325, 3.5,
7.2, 1325, 4.5,
8.1, 1325, 4.5,
6.8, 1325, 4.5,
2.1, 1325, 1.75,
5.9, 1325, 3.5,
3.5, 1325, 2.5,
5.2, 1325, 3.5,
1.9, 1325, 1.75,
5.3, 1325, 3.5,
2.55, 1325, 1.75,
2.63, 1325, 1.75,
12.5, 1325, 5.5,
13.3, 1325, 5.5,
2.4, 1325, 1.75,
6.9, 1325, 4.5,
4.4, 1325, 3.5,
3.4, 1325, 2.5,
3.5, 1325, 2.5,
2.7, 1325, 2.5,
6.3, 1325, 3.5,
2.87, 1325, 1.5,
16.8, 1325, 5.5,
10.5, 1325, 5.5,
7.8, 1325, 4.5,
8.7, 1325, 5.5,
4.6, 1355, 2.5,
9.3, 1355, 4.5,
2.07, 1355, 1.5,
10.3, 1355, 4.5,
10.3, 1355, 4.5,
7.9, 1355, 2.5,
7.9, 1355, 3.5,
6.9, 1355, 3.5,
8.2, 1355, 3.5,
8.8, 1355, 3.5,
4.9, 1355, 2.5,
6.7, 1355, 3.5,
11.1, 1355, 4.5,
7.9, 1355, 4.5,
5.9, 1355, 2.5,
2.8, 1355, 1.75,
15, 1355, 5.5,
9.1, 1355, 3.5,
6, 1355, 3.5
]);
var buf134 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf134);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc134 = gl.getUniformLocation(prog134,"mvMatrix");
var prMatLoc134 = gl.getUniformLocation(prog134,"prMatrix");
// ****** lines object 135 ******
var prog135  = gl.createProgram();
gl.attachShader(prog135, getShader( gl, "unnamed_chunk_4vshader135" ));
gl.attachShader(prog135, getShader( gl, "unnamed_chunk_4fshader135" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog135, 0, "aPos");
gl.bindAttribLocation(prog135, 1, "aCol");
gl.linkProgram(prog135);
var v=new Float32Array([
0, 1185.835, 1.172935,
30, 1185.835, 1.172935,
0, 1185.835, 1.172935,
0, 1180.402, 0.8346412,
5, 1185.835, 1.172935,
5, 1180.402, 0.8346412,
10, 1185.835, 1.172935,
10, 1180.402, 0.8346412,
15, 1185.835, 1.172935,
15, 1180.402, 0.8346412,
20, 1185.835, 1.172935,
20, 1180.402, 0.8346412,
25, 1185.835, 1.172935,
25, 1180.402, 0.8346412,
30, 1185.835, 1.172935,
30, 1180.402, 0.8346412
]);
var buf135 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf135);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc135 = gl.getUniformLocation(prog135,"mvMatrix");
var prMatLoc135 = gl.getUniformLocation(prog135,"prMatrix");
// ****** text object 136 ******
var prog136  = gl.createProgram();
gl.attachShader(prog136, getShader( gl, "unnamed_chunk_4vshader136" ));
gl.attachShader(prog136, getShader( gl, "unnamed_chunk_4fshader136" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog136, 0, "aPos");
gl.bindAttribLocation(prog136, 1, "aCol");
gl.linkProgram(prog136);
var texts = [
"0",
"5",
"10",
"15",
"20",
"25",
"30"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX136 = texinfo.canvasX;
var canvasY136 = texinfo.canvasY;
var ofsLoc136 = gl.getAttribLocation(prog136, "aOfs");
var texture136 = gl.createTexture();
var texLoc136 = gl.getAttribLocation(prog136, "aTexcoord");
var sampler136 = gl.getUniformLocation(prog136,"uSampler");
handleLoadedTexture(texture136, document.getElementById("unnamed_chunk_4textureCanvas"));
var v=new Float32Array([
0, 1169.535, 0.1580527, 0, -0.5, 0.5, 0.5,
0, 1169.535, 0.1580527, 1, -0.5, 0.5, 0.5,
0, 1169.535, 0.1580527, 1, 1.5, 0.5, 0.5,
0, 1169.535, 0.1580527, 0, 1.5, 0.5, 0.5,
5, 1169.535, 0.1580527, 0, -0.5, 0.5, 0.5,
5, 1169.535, 0.1580527, 1, -0.5, 0.5, 0.5,
5, 1169.535, 0.1580527, 1, 1.5, 0.5, 0.5,
5, 1169.535, 0.1580527, 0, 1.5, 0.5, 0.5,
10, 1169.535, 0.1580527, 0, -0.5, 0.5, 0.5,
10, 1169.535, 0.1580527, 1, -0.5, 0.5, 0.5,
10, 1169.535, 0.1580527, 1, 1.5, 0.5, 0.5,
10, 1169.535, 0.1580527, 0, 1.5, 0.5, 0.5,
15, 1169.535, 0.1580527, 0, -0.5, 0.5, 0.5,
15, 1169.535, 0.1580527, 1, -0.5, 0.5, 0.5,
15, 1169.535, 0.1580527, 1, 1.5, 0.5, 0.5,
15, 1169.535, 0.1580527, 0, 1.5, 0.5, 0.5,
20, 1169.535, 0.1580527, 0, -0.5, 0.5, 0.5,
20, 1169.535, 0.1580527, 1, -0.5, 0.5, 0.5,
20, 1169.535, 0.1580527, 1, 1.5, 0.5, 0.5,
20, 1169.535, 0.1580527, 0, 1.5, 0.5, 0.5,
25, 1169.535, 0.1580527, 0, -0.5, 0.5, 0.5,
25, 1169.535, 0.1580527, 1, -0.5, 0.5, 0.5,
25, 1169.535, 0.1580527, 1, 1.5, 0.5, 0.5,
25, 1169.535, 0.1580527, 0, 1.5, 0.5, 0.5,
30, 1169.535, 0.1580527, 0, -0.5, 0.5, 0.5,
30, 1169.535, 0.1580527, 1, -0.5, 0.5, 0.5,
30, 1169.535, 0.1580527, 1, 1.5, 0.5, 0.5,
30, 1169.535, 0.1580527, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<7; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23,
24, 25, 26, 24, 26, 27
]);
var buf136 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf136);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf136 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf136);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc136 = gl.getUniformLocation(prog136,"mvMatrix");
var prMatLoc136 = gl.getUniformLocation(prog136,"prMatrix");
var textScaleLoc136 = gl.getUniformLocation(prog136,"textScale");
// ****** lines object 137 ******
var prog137  = gl.createProgram();
gl.attachShader(prog137, getShader( gl, "unnamed_chunk_4vshader137" ));
gl.attachShader(prog137, getShader( gl, "unnamed_chunk_4fshader137" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog137, 0, "aPos");
gl.bindAttribLocation(prog137, 1, "aCol");
gl.linkProgram(prog137);
var v=new Float32Array([
-0.4815, 1200, 1.172935,
-0.4815, 1400, 1.172935,
-0.4815, 1200, 1.172935,
-1.308075, 1200, 0.8346412,
-0.4815, 1250, 1.172935,
-1.308075, 1250, 0.8346412,
-0.4815, 1300, 1.172935,
-1.308075, 1300, 0.8346412,
-0.4815, 1350, 1.172935,
-1.308075, 1350, 0.8346412,
-0.4815, 1400, 1.172935,
-1.308075, 1400, 0.8346412
]);
var buf137 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf137);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc137 = gl.getUniformLocation(prog137,"mvMatrix");
var prMatLoc137 = gl.getUniformLocation(prog137,"prMatrix");
// ****** text object 138 ******
var prog138  = gl.createProgram();
gl.attachShader(prog138, getShader( gl, "unnamed_chunk_4vshader138" ));
gl.attachShader(prog138, getShader( gl, "unnamed_chunk_4fshader138" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog138, 0, "aPos");
gl.bindAttribLocation(prog138, 1, "aCol");
gl.linkProgram(prog138);
var texts = [
"1200",
"1250",
"1300",
"1350",
"1400"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX138 = texinfo.canvasX;
var canvasY138 = texinfo.canvasY;
var ofsLoc138 = gl.getAttribLocation(prog138, "aOfs");
var texture138 = gl.createTexture();
var texLoc138 = gl.getAttribLocation(prog138, "aTexcoord");
var sampler138 = gl.getUniformLocation(prog138,"uSampler");
handleLoadedTexture(texture138, document.getElementById("unnamed_chunk_4textureCanvas"));
var v=new Float32Array([
-2.961225, 1200, 0.1580527, 0, -0.5, 0.5, 0.5,
-2.961225, 1200, 0.1580527, 1, -0.5, 0.5, 0.5,
-2.961225, 1200, 0.1580527, 1, 1.5, 0.5, 0.5,
-2.961225, 1200, 0.1580527, 0, 1.5, 0.5, 0.5,
-2.961225, 1250, 0.1580527, 0, -0.5, 0.5, 0.5,
-2.961225, 1250, 0.1580527, 1, -0.5, 0.5, 0.5,
-2.961225, 1250, 0.1580527, 1, 1.5, 0.5, 0.5,
-2.961225, 1250, 0.1580527, 0, 1.5, 0.5, 0.5,
-2.961225, 1300, 0.1580527, 0, -0.5, 0.5, 0.5,
-2.961225, 1300, 0.1580527, 1, -0.5, 0.5, 0.5,
-2.961225, 1300, 0.1580527, 1, 1.5, 0.5, 0.5,
-2.961225, 1300, 0.1580527, 0, 1.5, 0.5, 0.5,
-2.961225, 1350, 0.1580527, 0, -0.5, 0.5, 0.5,
-2.961225, 1350, 0.1580527, 1, -0.5, 0.5, 0.5,
-2.961225, 1350, 0.1580527, 1, 1.5, 0.5, 0.5,
-2.961225, 1350, 0.1580527, 0, 1.5, 0.5, 0.5,
-2.961225, 1400, 0.1580527, 0, -0.5, 0.5, 0.5,
-2.961225, 1400, 0.1580527, 1, -0.5, 0.5, 0.5,
-2.961225, 1400, 0.1580527, 1, 1.5, 0.5, 0.5,
-2.961225, 1400, 0.1580527, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<5; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19
]);
var buf138 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf138);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf138 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf138);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc138 = gl.getUniformLocation(prog138,"mvMatrix");
var prMatLoc138 = gl.getUniformLocation(prog138,"prMatrix");
var textScaleLoc138 = gl.getUniformLocation(prog138,"textScale");
// ****** lines object 139 ******
var prog139  = gl.createProgram();
gl.attachShader(prog139, getShader( gl, "unnamed_chunk_4vshader139" ));
gl.attachShader(prog139, getShader( gl, "unnamed_chunk_4fshader139" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog139, 0, "aPos");
gl.bindAttribLocation(prog139, 1, "aCol");
gl.linkProgram(prog139);
var v=new Float32Array([
-0.4815, 1185.835, 2,
-0.4815, 1185.835, 14,
-0.4815, 1185.835, 2,
-1.308075, 1180.402, 2,
-0.4815, 1185.835, 4,
-1.308075, 1180.402, 4,
-0.4815, 1185.835, 6,
-1.308075, 1180.402, 6,
-0.4815, 1185.835, 8,
-1.308075, 1180.402, 8,
-0.4815, 1185.835, 10,
-1.308075, 1180.402, 10,
-0.4815, 1185.835, 12,
-1.308075, 1180.402, 12,
-0.4815, 1185.835, 14,
-1.308075, 1180.402, 14
]);
var buf139 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf139);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc139 = gl.getUniformLocation(prog139,"mvMatrix");
var prMatLoc139 = gl.getUniformLocation(prog139,"prMatrix");
// ****** text object 140 ******
var prog140  = gl.createProgram();
gl.attachShader(prog140, getShader( gl, "unnamed_chunk_4vshader140" ));
gl.attachShader(prog140, getShader( gl, "unnamed_chunk_4fshader140" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog140, 0, "aPos");
gl.bindAttribLocation(prog140, 1, "aCol");
gl.linkProgram(prog140);
var texts = [
"2",
"4",
"6",
"8",
"10",
"12",
"14"
];
var texinfo = drawTextToCanvas(texts, 1);	 
var canvasX140 = texinfo.canvasX;
var canvasY140 = texinfo.canvasY;
var ofsLoc140 = gl.getAttribLocation(prog140, "aOfs");
var texture140 = gl.createTexture();
var texLoc140 = gl.getAttribLocation(prog140, "aTexcoord");
var sampler140 = gl.getUniformLocation(prog140,"uSampler");
handleLoadedTexture(texture140, document.getElementById("unnamed_chunk_4textureCanvas"));
var v=new Float32Array([
-2.961225, 1169.535, 2, 0, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 2, 1, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 2, 1, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 2, 0, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 4, 0, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 4, 1, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 4, 1, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 4, 0, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 6, 0, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 6, 1, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 6, 1, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 6, 0, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 8, 0, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 8, 1, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 8, 1, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 8, 0, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 10, 0, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 10, 1, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 10, 1, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 10, 0, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 12, 0, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 12, 1, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 12, 1, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 12, 0, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 14, 0, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 14, 1, -0.5, 0.5, 0.5,
-2.961225, 1169.535, 14, 1, 1.5, 0.5, 0.5,
-2.961225, 1169.535, 14, 0, 1.5, 0.5, 0.5
]);
for (var i=0; i<7; i++) 
for (var j=0; j<4; j++) {
var ind = 7*(4*i + j) + 3;
v[ind+2] = 2*(v[ind]-v[ind+2])*texinfo.widths[i];
v[ind+3] = 2*(v[ind+1]-v[ind+3])*texinfo.textHeight;
v[ind] *= texinfo.widths[i]/texinfo.canvasX;
v[ind+1] = 1.0-(texinfo.offset + i*texinfo.skip 
- v[ind+1]*texinfo.textHeight)/texinfo.canvasY;
}
var f=new Uint16Array([
0, 1, 2, 0, 2, 3,
4, 5, 6, 4, 6, 7,
8, 9, 10, 8, 10, 11,
12, 13, 14, 12, 14, 15,
16, 17, 18, 16, 18, 19,
20, 21, 22, 20, 22, 23,
24, 25, 26, 24, 26, 27
]);
var buf140 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf140);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var ibuf140 = gl.createBuffer();
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf140);
gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, f, gl.STATIC_DRAW);
var mvMatLoc140 = gl.getUniformLocation(prog140,"mvMatrix");
var prMatLoc140 = gl.getUniformLocation(prog140,"prMatrix");
var textScaleLoc140 = gl.getUniformLocation(prog140,"textScale");
// ****** lines object 141 ******
var prog141  = gl.createProgram();
gl.attachShader(prog141, getShader( gl, "unnamed_chunk_4vshader141" ));
gl.attachShader(prog141, getShader( gl, "unnamed_chunk_4fshader141" ));
//  Force aPos to location 0, aCol to location 1 
gl.bindAttribLocation(prog141, 0, "aPos");
gl.bindAttribLocation(prog141, 1, "aCol");
gl.linkProgram(prog141);
var v=new Float32Array([
-0.4815, 1185.835, 1.172935,
-0.4815, 1403.165, 1.172935,
-0.4815, 1185.835, 14.7047,
-0.4815, 1403.165, 14.7047,
-0.4815, 1185.835, 1.172935,
-0.4815, 1185.835, 14.7047,
-0.4815, 1403.165, 1.172935,
-0.4815, 1403.165, 14.7047,
-0.4815, 1185.835, 1.172935,
32.5815, 1185.835, 1.172935,
-0.4815, 1185.835, 14.7047,
32.5815, 1185.835, 14.7047,
-0.4815, 1403.165, 1.172935,
32.5815, 1403.165, 1.172935,
-0.4815, 1403.165, 14.7047,
32.5815, 1403.165, 14.7047,
32.5815, 1185.835, 1.172935,
32.5815, 1403.165, 1.172935,
32.5815, 1185.835, 14.7047,
32.5815, 1403.165, 14.7047,
32.5815, 1185.835, 1.172935,
32.5815, 1185.835, 14.7047,
32.5815, 1403.165, 1.172935,
32.5815, 1403.165, 14.7047
]);
var buf141 = gl.createBuffer();
gl.bindBuffer(gl.ARRAY_BUFFER, buf141);
gl.bufferData(gl.ARRAY_BUFFER, v, gl.STATIC_DRAW);
var mvMatLoc141 = gl.getUniformLocation(prog141,"mvMatrix");
var prMatLoc141 = gl.getUniformLocation(prog141,"prMatrix");
gl.enable(gl.DEPTH_TEST);
gl.depthFunc(gl.LEQUAL);
gl.clearDepth(1.0);
gl.clearColor(1,1,1,1);
var xOffs = 0, yOffs = 0, drag  = 0;
function multMV(M, v) {
return [M.m11*v[0] + M.m12*v[1] + M.m13*v[2] + M.m14*v[3],
M.m21*v[0] + M.m22*v[1] + M.m23*v[2] + M.m24*v[3],
M.m31*v[0] + M.m32*v[1] + M.m33*v[2] + M.m34*v[3],
M.m41*v[0] + M.m42*v[1] + M.m43*v[2] + M.m44*v[3]];
}
drawScene();
function drawScene(){
gl.depthMask(true);
gl.disable(gl.BLEND);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
// ***** subscene 1 ****
gl.viewport(0, 0, 504, 504);
gl.scissor(0, 0, 504, 504);
gl.clearColor(1, 1, 1, 1);
gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
var radius = 176.4622;
var distance = 785.1;
var t = tan(fov[1]*PI/360);
var near = distance - radius;
var far = distance + radius;
var hlen = t*near;
var aspect = 1;
prMatrix.makeIdentity();
if (aspect > 1)
prMatrix.frustum(-hlen*aspect*zoom[1], hlen*aspect*zoom[1], 
-hlen*zoom[1], hlen*zoom[1], near, far);
else  
prMatrix.frustum(-hlen*zoom[1], hlen*zoom[1], 
-hlen*zoom[1]/aspect, hlen*zoom[1]/aspect, 
near, far);
mvMatrix.makeIdentity();
mvMatrix.translate( -16.05, -1294.5, -7.93882 );
mvMatrix.scale( 5.608048, 0.5807386, 17.93474 );   
mvMatrix.multRight( userMatrix[1] );
mvMatrix.translate(-0, -0, -785.1);
// ****** text object 54 *******
gl.useProgram(prog54);
gl.bindBuffer(gl.ARRAY_BUFFER, buf54);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf54);
gl.uniformMatrix4fv( prMatLoc54, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc54, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc54, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc54 );
gl.vertexAttribPointer(texLoc54, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture54);
gl.uniform1i( sampler54, 0);
gl.enableVertexAttribArray( ofsLoc54 );
gl.vertexAttribPointer(ofsLoc54, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
// ****** text object 55 *******
gl.useProgram(prog55);
gl.bindBuffer(gl.ARRAY_BUFFER, buf55);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf55);
gl.uniformMatrix4fv( prMatLoc55, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc55, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc55, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc55 );
gl.vertexAttribPointer(texLoc55, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture55);
gl.uniform1i( sampler55, 0);
gl.enableVertexAttribArray( ofsLoc55 );
gl.vertexAttribPointer(ofsLoc55, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
// ****** text object 56 *******
gl.useProgram(prog56);
gl.bindBuffer(gl.ARRAY_BUFFER, buf56);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf56);
gl.uniformMatrix4fv( prMatLoc56, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc56, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc56, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc56 );
gl.vertexAttribPointer(texLoc56, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture56);
gl.uniform1i( sampler56, 0);
gl.enableVertexAttribArray( ofsLoc56 );
gl.vertexAttribPointer(ofsLoc56, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
// ****** text object 57 *******
gl.useProgram(prog57);
gl.bindBuffer(gl.ARRAY_BUFFER, buf57);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf57);
gl.uniformMatrix4fv( prMatLoc57, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc57, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc57, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc57 );
gl.vertexAttribPointer(texLoc57, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture57);
gl.uniform1i( sampler57, 0);
gl.enableVertexAttribArray( ofsLoc57 );
gl.vertexAttribPointer(ofsLoc57, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 6, gl.UNSIGNED_SHORT, 0);
// ****** points object 58 *******
gl.useProgram(prog58);
gl.bindBuffer(gl.ARRAY_BUFFER, buf58);
gl.uniformMatrix4fv( prMatLoc58, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc58, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.POINTS, 0, 1050);
// ****** points object 133 *******
gl.useProgram(prog133);
gl.bindBuffer(gl.ARRAY_BUFFER, buf133);
gl.uniformMatrix4fv( prMatLoc133, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc133, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.POINTS, 0, 1156);
// ****** points object 134 *******
gl.useProgram(prog134);
gl.bindBuffer(gl.ARRAY_BUFFER, buf134);
gl.uniformMatrix4fv( prMatLoc134, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc134, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.POINTS, 0, 1050);
// ****** lines object 135 *******
gl.useProgram(prog135);
gl.bindBuffer(gl.ARRAY_BUFFER, buf135);
gl.uniformMatrix4fv( prMatLoc135, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc135, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINES, 0, 16);
// ****** text object 136 *******
gl.useProgram(prog136);
gl.bindBuffer(gl.ARRAY_BUFFER, buf136);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf136);
gl.uniformMatrix4fv( prMatLoc136, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc136, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc136, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc136 );
gl.vertexAttribPointer(texLoc136, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture136);
gl.uniform1i( sampler136, 0);
gl.enableVertexAttribArray( ofsLoc136 );
gl.vertexAttribPointer(ofsLoc136, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 42, gl.UNSIGNED_SHORT, 0);
// ****** lines object 137 *******
gl.useProgram(prog137);
gl.bindBuffer(gl.ARRAY_BUFFER, buf137);
gl.uniformMatrix4fv( prMatLoc137, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc137, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINES, 0, 12);
// ****** text object 138 *******
gl.useProgram(prog138);
gl.bindBuffer(gl.ARRAY_BUFFER, buf138);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf138);
gl.uniformMatrix4fv( prMatLoc138, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc138, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc138, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc138 );
gl.vertexAttribPointer(texLoc138, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture138);
gl.uniform1i( sampler138, 0);
gl.enableVertexAttribArray( ofsLoc138 );
gl.vertexAttribPointer(ofsLoc138, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 30, gl.UNSIGNED_SHORT, 0);
// ****** lines object 139 *******
gl.useProgram(prog139);
gl.bindBuffer(gl.ARRAY_BUFFER, buf139);
gl.uniformMatrix4fv( prMatLoc139, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc139, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINES, 0, 16);
// ****** text object 140 *******
gl.useProgram(prog140);
gl.bindBuffer(gl.ARRAY_BUFFER, buf140);
gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, ibuf140);
gl.uniformMatrix4fv( prMatLoc140, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc140, false, new Float32Array(mvMatrix.getAsArray()) );
gl.uniform2f( textScaleLoc140, 0.001488095, 0.001488095);
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.enableVertexAttribArray( texLoc140 );
gl.vertexAttribPointer(texLoc140, 2, gl.FLOAT, false, 28, 12);
gl.activeTexture(gl.TEXTURE0);
gl.bindTexture(gl.TEXTURE_2D, texture140);
gl.uniform1i( sampler140, 0);
gl.enableVertexAttribArray( ofsLoc140 );
gl.vertexAttribPointer(ofsLoc140, 2, gl.FLOAT, false, 28, 20);
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 28,  0);
gl.drawElements(gl.TRIANGLES, 42, gl.UNSIGNED_SHORT, 0);
// ****** lines object 141 *******
gl.useProgram(prog141);
gl.bindBuffer(gl.ARRAY_BUFFER, buf141);
gl.uniformMatrix4fv( prMatLoc141, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc141, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 1 );
gl.lineWidth( 1 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINES, 0, 24);
// ***** Transparent objects next ****
gl.depthMask(false);
gl.blendFuncSeparate(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA,
gl.ONE, gl.ONE);
gl.enable(gl.BLEND);
// ****** points object 52 *******
gl.useProgram(prog52);
gl.bindBuffer(gl.ARRAY_BUFFER, buf52);
gl.uniformMatrix4fv( prMatLoc52, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc52, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.POINTS, 0, 1156);
// ****** linestrip object 61 *******
gl.useProgram(prog61);
gl.bindBuffer(gl.ARRAY_BUFFER, buf61);
gl.uniformMatrix4fv( prMatLoc61, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc61, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 62 *******
gl.useProgram(prog62);
gl.bindBuffer(gl.ARRAY_BUFFER, buf62);
gl.uniformMatrix4fv( prMatLoc62, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc62, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 63 *******
gl.useProgram(prog63);
gl.bindBuffer(gl.ARRAY_BUFFER, buf63);
gl.uniformMatrix4fv( prMatLoc63, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc63, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 64 *******
gl.useProgram(prog64);
gl.bindBuffer(gl.ARRAY_BUFFER, buf64);
gl.uniformMatrix4fv( prMatLoc64, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc64, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 65 *******
gl.useProgram(prog65);
gl.bindBuffer(gl.ARRAY_BUFFER, buf65);
gl.uniformMatrix4fv( prMatLoc65, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc65, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 66 *******
gl.useProgram(prog66);
gl.bindBuffer(gl.ARRAY_BUFFER, buf66);
gl.uniformMatrix4fv( prMatLoc66, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc66, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 67 *******
gl.useProgram(prog67);
gl.bindBuffer(gl.ARRAY_BUFFER, buf67);
gl.uniformMatrix4fv( prMatLoc67, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc67, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 68 *******
gl.useProgram(prog68);
gl.bindBuffer(gl.ARRAY_BUFFER, buf68);
gl.uniformMatrix4fv( prMatLoc68, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc68, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 69 *******
gl.useProgram(prog69);
gl.bindBuffer(gl.ARRAY_BUFFER, buf69);
gl.uniformMatrix4fv( prMatLoc69, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc69, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 70 *******
gl.useProgram(prog70);
gl.bindBuffer(gl.ARRAY_BUFFER, buf70);
gl.uniformMatrix4fv( prMatLoc70, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc70, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 71 *******
gl.useProgram(prog71);
gl.bindBuffer(gl.ARRAY_BUFFER, buf71);
gl.uniformMatrix4fv( prMatLoc71, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc71, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 72 *******
gl.useProgram(prog72);
gl.bindBuffer(gl.ARRAY_BUFFER, buf72);
gl.uniformMatrix4fv( prMatLoc72, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc72, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 73 *******
gl.useProgram(prog73);
gl.bindBuffer(gl.ARRAY_BUFFER, buf73);
gl.uniformMatrix4fv( prMatLoc73, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc73, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 74 *******
gl.useProgram(prog74);
gl.bindBuffer(gl.ARRAY_BUFFER, buf74);
gl.uniformMatrix4fv( prMatLoc74, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc74, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 75 *******
gl.useProgram(prog75);
gl.bindBuffer(gl.ARRAY_BUFFER, buf75);
gl.uniformMatrix4fv( prMatLoc75, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc75, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 76 *******
gl.useProgram(prog76);
gl.bindBuffer(gl.ARRAY_BUFFER, buf76);
gl.uniformMatrix4fv( prMatLoc76, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc76, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 77 *******
gl.useProgram(prog77);
gl.bindBuffer(gl.ARRAY_BUFFER, buf77);
gl.uniformMatrix4fv( prMatLoc77, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc77, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 78 *******
gl.useProgram(prog78);
gl.bindBuffer(gl.ARRAY_BUFFER, buf78);
gl.uniformMatrix4fv( prMatLoc78, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc78, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 79 *******
gl.useProgram(prog79);
gl.bindBuffer(gl.ARRAY_BUFFER, buf79);
gl.uniformMatrix4fv( prMatLoc79, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc79, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 80 *******
gl.useProgram(prog80);
gl.bindBuffer(gl.ARRAY_BUFFER, buf80);
gl.uniformMatrix4fv( prMatLoc80, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc80, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 81 *******
gl.useProgram(prog81);
gl.bindBuffer(gl.ARRAY_BUFFER, buf81);
gl.uniformMatrix4fv( prMatLoc81, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc81, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 82 *******
gl.useProgram(prog82);
gl.bindBuffer(gl.ARRAY_BUFFER, buf82);
gl.uniformMatrix4fv( prMatLoc82, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc82, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 83 *******
gl.useProgram(prog83);
gl.bindBuffer(gl.ARRAY_BUFFER, buf83);
gl.uniformMatrix4fv( prMatLoc83, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc83, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 84 *******
gl.useProgram(prog84);
gl.bindBuffer(gl.ARRAY_BUFFER, buf84);
gl.uniformMatrix4fv( prMatLoc84, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc84, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 85 *******
gl.useProgram(prog85);
gl.bindBuffer(gl.ARRAY_BUFFER, buf85);
gl.uniformMatrix4fv( prMatLoc85, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc85, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 86 *******
gl.useProgram(prog86);
gl.bindBuffer(gl.ARRAY_BUFFER, buf86);
gl.uniformMatrix4fv( prMatLoc86, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc86, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 87 *******
gl.useProgram(prog87);
gl.bindBuffer(gl.ARRAY_BUFFER, buf87);
gl.uniformMatrix4fv( prMatLoc87, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc87, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 88 *******
gl.useProgram(prog88);
gl.bindBuffer(gl.ARRAY_BUFFER, buf88);
gl.uniformMatrix4fv( prMatLoc88, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc88, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 89 *******
gl.useProgram(prog89);
gl.bindBuffer(gl.ARRAY_BUFFER, buf89);
gl.uniformMatrix4fv( prMatLoc89, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc89, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 90 *******
gl.useProgram(prog90);
gl.bindBuffer(gl.ARRAY_BUFFER, buf90);
gl.uniformMatrix4fv( prMatLoc90, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc90, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 91 *******
gl.useProgram(prog91);
gl.bindBuffer(gl.ARRAY_BUFFER, buf91);
gl.uniformMatrix4fv( prMatLoc91, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc91, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 92 *******
gl.useProgram(prog92);
gl.bindBuffer(gl.ARRAY_BUFFER, buf92);
gl.uniformMatrix4fv( prMatLoc92, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc92, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 93 *******
gl.useProgram(prog93);
gl.bindBuffer(gl.ARRAY_BUFFER, buf93);
gl.uniformMatrix4fv( prMatLoc93, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc93, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 94 *******
gl.useProgram(prog94);
gl.bindBuffer(gl.ARRAY_BUFFER, buf94);
gl.uniformMatrix4fv( prMatLoc94, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc94, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 95 *******
gl.useProgram(prog95);
gl.bindBuffer(gl.ARRAY_BUFFER, buf95);
gl.uniformMatrix4fv( prMatLoc95, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc95, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 96 *******
gl.useProgram(prog96);
gl.bindBuffer(gl.ARRAY_BUFFER, buf96);
gl.uniformMatrix4fv( prMatLoc96, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc96, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 0, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 97 *******
gl.useProgram(prog97);
gl.bindBuffer(gl.ARRAY_BUFFER, buf97);
gl.uniformMatrix4fv( prMatLoc97, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc97, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 98 *******
gl.useProgram(prog98);
gl.bindBuffer(gl.ARRAY_BUFFER, buf98);
gl.uniformMatrix4fv( prMatLoc98, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc98, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 99 *******
gl.useProgram(prog99);
gl.bindBuffer(gl.ARRAY_BUFFER, buf99);
gl.uniformMatrix4fv( prMatLoc99, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc99, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 100 *******
gl.useProgram(prog100);
gl.bindBuffer(gl.ARRAY_BUFFER, buf100);
gl.uniformMatrix4fv( prMatLoc100, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc100, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 101 *******
gl.useProgram(prog101);
gl.bindBuffer(gl.ARRAY_BUFFER, buf101);
gl.uniformMatrix4fv( prMatLoc101, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc101, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 102 *******
gl.useProgram(prog102);
gl.bindBuffer(gl.ARRAY_BUFFER, buf102);
gl.uniformMatrix4fv( prMatLoc102, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc102, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 103 *******
gl.useProgram(prog103);
gl.bindBuffer(gl.ARRAY_BUFFER, buf103);
gl.uniformMatrix4fv( prMatLoc103, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc103, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 104 *******
gl.useProgram(prog104);
gl.bindBuffer(gl.ARRAY_BUFFER, buf104);
gl.uniformMatrix4fv( prMatLoc104, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc104, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 105 *******
gl.useProgram(prog105);
gl.bindBuffer(gl.ARRAY_BUFFER, buf105);
gl.uniformMatrix4fv( prMatLoc105, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc105, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 106 *******
gl.useProgram(prog106);
gl.bindBuffer(gl.ARRAY_BUFFER, buf106);
gl.uniformMatrix4fv( prMatLoc106, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc106, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 107 *******
gl.useProgram(prog107);
gl.bindBuffer(gl.ARRAY_BUFFER, buf107);
gl.uniformMatrix4fv( prMatLoc107, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc107, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 108 *******
gl.useProgram(prog108);
gl.bindBuffer(gl.ARRAY_BUFFER, buf108);
gl.uniformMatrix4fv( prMatLoc108, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc108, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 109 *******
gl.useProgram(prog109);
gl.bindBuffer(gl.ARRAY_BUFFER, buf109);
gl.uniformMatrix4fv( prMatLoc109, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc109, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 110 *******
gl.useProgram(prog110);
gl.bindBuffer(gl.ARRAY_BUFFER, buf110);
gl.uniformMatrix4fv( prMatLoc110, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc110, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 111 *******
gl.useProgram(prog111);
gl.bindBuffer(gl.ARRAY_BUFFER, buf111);
gl.uniformMatrix4fv( prMatLoc111, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc111, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 112 *******
gl.useProgram(prog112);
gl.bindBuffer(gl.ARRAY_BUFFER, buf112);
gl.uniformMatrix4fv( prMatLoc112, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc112, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 113 *******
gl.useProgram(prog113);
gl.bindBuffer(gl.ARRAY_BUFFER, buf113);
gl.uniformMatrix4fv( prMatLoc113, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc113, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 114 *******
gl.useProgram(prog114);
gl.bindBuffer(gl.ARRAY_BUFFER, buf114);
gl.uniformMatrix4fv( prMatLoc114, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc114, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 115 *******
gl.useProgram(prog115);
gl.bindBuffer(gl.ARRAY_BUFFER, buf115);
gl.uniformMatrix4fv( prMatLoc115, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc115, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 116 *******
gl.useProgram(prog116);
gl.bindBuffer(gl.ARRAY_BUFFER, buf116);
gl.uniformMatrix4fv( prMatLoc116, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc116, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 117 *******
gl.useProgram(prog117);
gl.bindBuffer(gl.ARRAY_BUFFER, buf117);
gl.uniformMatrix4fv( prMatLoc117, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc117, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 118 *******
gl.useProgram(prog118);
gl.bindBuffer(gl.ARRAY_BUFFER, buf118);
gl.uniformMatrix4fv( prMatLoc118, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc118, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 119 *******
gl.useProgram(prog119);
gl.bindBuffer(gl.ARRAY_BUFFER, buf119);
gl.uniformMatrix4fv( prMatLoc119, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc119, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 120 *******
gl.useProgram(prog120);
gl.bindBuffer(gl.ARRAY_BUFFER, buf120);
gl.uniformMatrix4fv( prMatLoc120, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc120, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 121 *******
gl.useProgram(prog121);
gl.bindBuffer(gl.ARRAY_BUFFER, buf121);
gl.uniformMatrix4fv( prMatLoc121, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc121, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 122 *******
gl.useProgram(prog122);
gl.bindBuffer(gl.ARRAY_BUFFER, buf122);
gl.uniformMatrix4fv( prMatLoc122, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc122, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 123 *******
gl.useProgram(prog123);
gl.bindBuffer(gl.ARRAY_BUFFER, buf123);
gl.uniformMatrix4fv( prMatLoc123, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc123, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 124 *******
gl.useProgram(prog124);
gl.bindBuffer(gl.ARRAY_BUFFER, buf124);
gl.uniformMatrix4fv( prMatLoc124, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc124, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 125 *******
gl.useProgram(prog125);
gl.bindBuffer(gl.ARRAY_BUFFER, buf125);
gl.uniformMatrix4fv( prMatLoc125, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc125, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 126 *******
gl.useProgram(prog126);
gl.bindBuffer(gl.ARRAY_BUFFER, buf126);
gl.uniformMatrix4fv( prMatLoc126, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc126, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 127 *******
gl.useProgram(prog127);
gl.bindBuffer(gl.ARRAY_BUFFER, buf127);
gl.uniformMatrix4fv( prMatLoc127, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc127, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 128 *******
gl.useProgram(prog128);
gl.bindBuffer(gl.ARRAY_BUFFER, buf128);
gl.uniformMatrix4fv( prMatLoc128, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc128, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 129 *******
gl.useProgram(prog129);
gl.bindBuffer(gl.ARRAY_BUFFER, buf129);
gl.uniformMatrix4fv( prMatLoc129, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc129, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 130 *******
gl.useProgram(prog130);
gl.bindBuffer(gl.ARRAY_BUFFER, buf130);
gl.uniformMatrix4fv( prMatLoc130, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc130, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 131 *******
gl.useProgram(prog131);
gl.bindBuffer(gl.ARRAY_BUFFER, buf131);
gl.uniformMatrix4fv( prMatLoc131, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc131, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
// ****** linestrip object 132 *******
gl.useProgram(prog132);
gl.bindBuffer(gl.ARRAY_BUFFER, buf132);
gl.uniformMatrix4fv( prMatLoc132, false, new Float32Array(prMatrix.getAsArray()) );
gl.uniformMatrix4fv( mvMatLoc132, false, new Float32Array(mvMatrix.getAsArray()) );
gl.enableVertexAttribArray( posLoc );
gl.disableVertexAttribArray( colLoc );
gl.vertexAttrib4f( colLoc, 1, 0, 0, 0.2 );
gl.lineWidth( 2 );
gl.vertexAttribPointer(posLoc,  3, gl.FLOAT, false, 12,  0);
gl.drawArrays(gl.LINE_STRIP, 0, 50);
gl.flush ();
}
var vpx0 = {
1: 0
};
var vpy0 = {
1: 0
};
var vpWidths = {
1: 504
};
var vpHeights = {
1: 504
};
var activeModel = {
1: 1
};
var activeProjection = {
1: 1
};
var listeners = {
1: [ 1 ]
};
var whichSubscene = function(coords){
if (0 <= coords.x && coords.x <= 504 && 0 <= coords.y && coords.y <= 504) return(1);
return(1);
}
var translateCoords = function(subsceneid, coords){
return {x:coords.x - vpx0[subsceneid], y:coords.y - vpy0[subsceneid]};
}
var vlen = function(v) {
return sqrt(v[0]*v[0] + v[1]*v[1] + v[2]*v[2])
}
var xprod = function(a, b) {
return [a[1]*b[2] - a[2]*b[1],
a[2]*b[0] - a[0]*b[2],
a[0]*b[1] - a[1]*b[0]];
}
var screenToVector = function(x, y) {
var width = vpWidths[activeSubscene];
var height = vpHeights[activeSubscene];
var radius = max(width, height)/2.0;
var cx = width/2.0;
var cy = height/2.0;
var px = (x-cx)/radius;
var py = (y-cy)/radius;
var plen = sqrt(px*px+py*py);
if (plen > 1.e-6) { 
px = px/plen;
py = py/plen;
}
var angle = (SQRT2 - plen)/SQRT2*PI/2;
var z = sin(angle);
var zlen = sqrt(1.0 - z*z);
px = px * zlen;
py = py * zlen;
return [px, py, z];
}
var rotBase;
var trackballdown = function(x,y) {
rotBase = screenToVector(x, y);
var l = listeners[activeModel[activeSubscene]];
saveMat = new Object();
for (var i = 0; i < l.length; i++) 
saveMat[l[i]] = new CanvasMatrix4(userMatrix[l[i]]);
}
var trackballmove = function(x,y) {
var rotCurrent = screenToVector(x,y);
var dot = rotBase[0]*rotCurrent[0] + 
rotBase[1]*rotCurrent[1] + 
rotBase[2]*rotCurrent[2];
var angle = acos( dot/vlen(rotBase)/vlen(rotCurrent) )*180./PI;
var axis = xprod(rotBase, rotCurrent);
var l = listeners[activeModel[activeSubscene]];
for (i = 0; i < l.length; i++) {
userMatrix[l[i]].load(saveMat[l[i]]);
userMatrix[l[i]].rotate(angle, axis[0], axis[1], axis[2]);
}
drawScene();
}
var y0zoom = 0;
var zoom0 = 0;
var zoomdown = function(x, y) {
y0zoom = y;
zoom0 = new Object();
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
zoom0[l[i]] = log(zoom[l[i]]);
}
var zoommove = function(x, y) {
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
zoom[l[i]] = exp(zoom0[l[i]] + (y-y0zoom)/height);
drawScene();
}
var y0fov = 0;
var fov0 = 1;
var fovdown = function(x, y) {
y0fov = y;
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
fov0 = fov[l[i]];
}
var fovmove = function(x, y) {
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
fov[l[i]] = max(1, min(179, fov0[l[i]] + 180*(y-y0fov)/height));
drawScene();
}
var mousedown = [trackballdown, zoomdown, fovdown];
var mousemove = [trackballmove, zoommove, fovmove];
function relMouseCoords(event){
var totalOffsetX = 0;
var totalOffsetY = 0;
var currentElement = canvas;
do{
totalOffsetX += currentElement.offsetLeft;
totalOffsetY += currentElement.offsetTop;
currentElement = currentElement.offsetParent;
}
while(currentElement)
var canvasX = event.pageX - totalOffsetX;
var canvasY = event.pageY - totalOffsetY;
return {x:canvasX, y:canvasY}
}
canvas.onmousedown = function ( ev ){
if (!ev.which) // Use w3c defns in preference to MS
switch (ev.button) {
case 0: ev.which = 1; break;
case 1: 
case 4: ev.which = 2; break;
case 2: ev.which = 3;
}
drag = ev.which;
var f = mousedown[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height-coords.y;
activeSubscene = whichSubscene(coords);
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y); 
ev.preventDefault();
}
}    
canvas.onmouseup = function ( ev ){	
drag = 0;
}
canvas.onmouseout = canvas.onmouseup;
canvas.onmousemove = function ( ev ){
if ( drag == 0 ) return;
var f = mousemove[drag-1];
if (f) {
var coords = relMouseCoords(ev);
coords.y = height - coords.y;
coords = translateCoords(activeSubscene, coords);
f(coords.x, coords.y);
}
}
var wheelHandler = function(ev) {
var del = 1.1;
if (ev.shiftKey) del = 1.01;
var ds = ((ev.detail || ev.wheelDelta) > 0) ? del : (1 / del);
l = listeners[activeProjection[activeSubscene]];
for (i = 0; i < l.length; i++)
zoom[l[i]] *= ds;
drawScene();
ev.preventDefault();
};
canvas.addEventListener("DOMMouseScroll", wheelHandler, false);
canvas.addEventListener("mousewheel", wheelHandler, false);
}
</script>
<canvas id="unnamed_chunk_4canvas" width="1" height="1"></canvas> 
<p id="unnamed_chunk_4debug">
You must enable Javascript to view this page properly.</p>
<script>unnamed_chunk_4webGLStart();</script>

## Best fits
Gompertz full model is fitting best for ABBA.

### 99

```r
summary(f99)
```

```
## Maximum likelihood estimation
## 
## Call:
## mle2(minuslogl = normNLL, start = unlist(ps, recursive = FALSE), 
##     method = method, data = list(x = dat[, ht], dbh = dat[, dbh], 
##         elev = dat[, "ELEV"], canht = dat[, "canht"]), control = list(maxit = maxit))
## 
## Coefficients:
##       Estimate  Std. Error     z value     Pr(z)    
## b   3.1573e+00  2.1258e-07  1.4853e+07 < 2.2e-16 ***
## b1 -2.8730e-03  2.7942e-04 -1.0282e+01 < 2.2e-16 ***
## b2  4.2558e-01  4.7128e-08  9.0301e+06 < 2.2e-16 ***
## b3  6.2263e-04  5.2989e-05  1.1750e+01 < 2.2e-16 ***
## a   1.1745e+00  1.5326e-07  7.6635e+06 < 2.2e-16 ***
## a1 -6.9071e-04  1.5334e-05 -4.5045e+01 < 2.2e-16 ***
## a2 -1.0215e-01  9.1290e-07 -1.1189e+05 < 2.2e-16 ***
## a3  6.4824e-05  2.4496e-06  2.6464e+01 < 2.2e-16 ***
## sd  6.8842e-01  2.9150e-09  2.3617e+08 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## -2 log L: 2417.336
```
### 11

```r
summary(f11)
```

```
## Warning in sqrt(diag(object@vcov)): NaNs produced
```

```
## Maximum likelihood estimation
## 
## Call:
## mle2(minuslogl = normNLL, start = unlist(ps, recursive = FALSE), 
##     method = method, data = list(x = dat[, ht], dbh = dat[, dbh], 
##         elev = dat[, "ELEV"], canht = dat[, "canht"]), control = list(maxit = maxit))
## 
## Coefficients:
##       Estimate  Std. Error     z value     Pr(z)    
## b   2.0548e+00  1.7662e-07  1.1634e+07 < 2.2e-16 ***
## b1 -9.6035e-04  2.4411e-04 -3.9340e+00 8.353e-05 ***
## b2  7.2599e-01  1.4165e-07  5.1251e+06 < 2.2e-16 ***
## b3  2.4095e-04  2.7697e-05  8.6996e+00 < 2.2e-16 ***
## a   5.1311e-01  4.9487e-07  1.0369e+06 < 2.2e-16 ***
## a1 -2.8921e-04          NA          NA        NA    
## a2  1.4817e-02  7.3609e-05  2.0130e+02 < 2.2e-16 ***
## a3 -9.8396e-06          NA          NA        NA    
## sd  1.2928e+00  9.5752e-07  1.3502e+06 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## -2 log L: 3475.371
```


# Profiles
## ABBA, gompertz full

```
## Error in .local(fitted, ...): object 'ps' not found
```

```
## Error in plot(p1): error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'p1' not found
```

## BECO, power/gompertz canopy only (11) and full gompertz (99)


### 99

```r
summary(f99)
```

```
## Maximum likelihood estimation
## 
## Call:
## mle2(minuslogl = normNLL, start = unlist(ps, recursive = FALSE), 
##     method = method, data = list(x = dat[, ht], dbh = dat[, dbh], 
##         elev = dat[, "ELEV"], canht = dat[, "canht"]), control = list(maxit = maxit))
## 
## Coefficients:
##       Estimate  Std. Error     z value     Pr(z)    
## b   1.7704e+00  6.4894e-07  2.7282e+06 < 2.2e-16 ***
## b1 -2.0188e-03  9.3524e-04 -2.1586e+00   0.03088 *  
## b2  1.2727e+00  6.4549e-07  1.9717e+06 < 2.2e-16 ***
## b3 -2.6385e-04  1.6047e-04 -1.6442e+00   0.10013    
## a   1.3681e+00  3.7142e-07  3.6834e+06 < 2.2e-16 ***
## a1  3.1711e-05  2.6770e-04  1.1850e-01   0.90571    
## a2  6.0908e-02  1.6049e-06  3.7952e+04 < 2.2e-16 ***
## a3 -1.6878e-04  3.7637e-05 -4.4845e+00 7.309e-06 ***
## sd  6.4970e-01  3.2676e-07  1.9883e+06 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## -2 log L: 175.7564
```



### 11

```r
source("~/work/hh/power/can/model.R")
summary(f11)
```

```
## Maximum likelihood estimation
## 
## Call:
## mle2(minuslogl = normNLL, start = unlist(ps, recursive = FALSE), 
##     method = method, data = list(x = dat[, ht], dbh = dat[, dbh], 
##         canht = dat[, "canht"]), control = list(maxit = maxit))
## 
## Coefficients:
##     Estimate Std. Error z value     Pr(z)    
## a   2.252335   0.397270  5.6695 1.432e-08 ***
## b  -0.147215   0.027708 -5.3132 1.077e-07 ***
## ap -0.457727   0.185586 -2.4664   0.01365 *  
## bp  0.133307   0.018136  7.3503 1.978e-13 ***
## sd  0.855352   0.073350 11.6612 < 2.2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## -2 log L: 171.7212
```

```r
p1 <- profile(fit)
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```
## Warning in onestep(step - 1 + dstep): Error encountered in profile: Error in (function (ps, dbh, canht)  : 
##   unused argument (c(5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 
## 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 1.55, 1.55, 1.55, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 7.3, 
## 7.3, 7.3, 7.3, 7.3, 7.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 5.3, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 
## 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 6.1, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 
## 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 7.1, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 
## 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 6.3, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 5.1, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 3.5, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 6.7, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 4.5, 6.5, 6.5, 6.5, 6.5, 
## 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 6.5, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 3.3, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 6.9, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 8.1, 
## 8.1, 8.1, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 5.7, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 4.9, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 
## 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 5.5, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7, 3.7))
```

```r
plot(p1)
```

```
## Error in x[ndat + (1L:deg) - deg]: only 0's may be mixed with negative subscripts
```
