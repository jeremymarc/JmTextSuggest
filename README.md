# JmTextSuggest

Mootools JavaScript Plugins to Suggest text according to the beginning of the
Text Input value.

## Usage 
```js
si = new JM.TextSuggest($('input-id'));
si.suggest('mytext');
```

## Methods
###suggest
Display the text next to the input value
```js
si = new JM.TextSuggest($('input-id'));
si.suggest('mytext');
```

###expend
Set the element value to the suggest value
```js
si = new JM.TextSuggest($('input-id'));
si.suggest('mytext');
si.expend();
```
