# Browser Snippets

Just some snippets of code to run in a browser.

Defeat Hard Sell content blockers (like on GlassDoor)

```JavaScript
document.getElementById('HardsellOverlay').outerHTML = "";
document.getElementsByTagName('body')[0].style = "";
document.body.onscroll = null;
```
