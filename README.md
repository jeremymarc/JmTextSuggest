# MtTextSuggest

Mootools JavaScript Plugins to Suggest text according to the beginning of the
Text Input value.

## Usage 
si = new SuggestInput($('input-id'));
si.suggest('mytext');

## Methods
###suggest
```js
Display the text next to the input value
si = new SuggestInput($('input-id'));
si.suggest('mytext');
```

###expend
Set the element value to the suggest value
```js
si = new SuggestInput($('input-id'));
si.suggest('mytext');
si.expend();
```
