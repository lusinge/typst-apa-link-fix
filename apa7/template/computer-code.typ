= Computer code
== Code block
#set raw(
  tab-size: 4,
  block: true,
)

#show raw.where(block: true): block.with(
  fill: luma(230),
  inset: 5pt,
  radius: 10pt,
)

#show raw: text.with(
  font: "Lucida Console",
  size: 10pt,
)

=== Code block as a figure

#show figure.where(kind: raw): it => {
  set align(left)
  it.caption
  it.body
} 

#figure(
  ```py
  def main():
      print("Hello, World!")
  ```,
  caption: [Python code block],
)

=== Non-figure code block

// #show raw.line: it => [
//   #box(width: 1em)[#it.number]
//   #h(1em)
//   #it.text
// ]

```cs
using System;

public class Program
{
    public static void Main(string[] args)
    {
        Console.WriteLine("Hello, World!");
    }
}

class MyClass
{
    public void MyMethod()
    {
        Console.WriteLine("Hello, World!");
    }
}

Console.WriteLine("Long line of code that exceeds the width of the page and needs to be wrapped to fit within the margins of the document.");
```

=== Parse file content

#raw(
  read("assets/src/main.py"),
  lang: "py",
)

== Inline code
Inline code can be inserted within a sentence, like this: `print("Hello, World!")`.