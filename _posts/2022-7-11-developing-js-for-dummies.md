---
layout: post
title: Developing javascript for simple people
---

I had to use a tiny bit of javascript for a project and I have never used javascript before. It was difficult to figure out where to even start since most tutorial start with "first, set up  Node.js". That was too much for me, here is what I found useful instead:

 1. Put your javascript code into html file, with body and everything. Then open the file in browser. That's it, but there are more than one way of doing this.

 2. Use javascript console in browser (press F12)

 3. For simple IDE, use VSCode with live preview extension. This will let you immediately see the changes you make.

 4. Use `console.log("some text")` or `console.log({message: "some text", value:object})` to get information into the console. The curly braces set up js object and the console will handily let you collapse its elements. Useful for looking into the guts of your program.

 5. Write `debugger;` in your code. Executing the code in browser, this will trigger breakpoint in console.

 6. Put

    ```js
        window.yourFun();
    ```

    into your javascript code. Then, you can redefine `window.yourFun()` in js console in browser

 7. There are loads of poor resources and SO questions (and answers) about javascript. MND Seems to be ok.

Next you can update your site name, avatar and other options using the _config.yml file in the root of your repository (shown below).

![_config.yml]({{ site.baseurl }}/images/config.png)

The easiest way to make your first post is to edit this one. Go into /_posts/ and update the Hello World markdown file. For more instructions head over to the [Jekyll Now repository](https://github.com/barryclark/jekyll-now) on GitHub.
