webpackJsonp([100,429],{1529:function(e,s,n){e.exports={frontmatter:n(530),content:n(2718)}},2718:function(e,s,n){e.exports='<section id=introduksjon> <h1 id=introduksjon>Introduksjon</h1> <p>En ting som mennesker ikke er så flinke til, men som datamaskiner er eksperter på, er å gjenta noe mange ganger etter hverandre. I python kan vi gjøre dette med løkker, og dere vil snart se at dette kan spare oss for mye tid og skriving.</p> </section> <section class=activity id=hello-world> <h1 class=activity id=hello-world>Hello world!</h1> <p>La oss ta et eksempel der vi vil ha Python til å si <strong>Hei!</strong> 100 ganger. En mulighet er da å sette i gang å skrive:</p> <pre><code class=python>print(<span class=hljs-string>"Hello  world!"</span>)\nprint(<span class=hljs-string>"Hello  world!"</span>)\nprint(<span class=hljs-string>"Hello  world!"</span>)\n...\n</code></pre> <p>Som du ser vil dette ta lang tid. Programmerere vil gjerne løse en oppgave på enklest mulig måte, og derfor har man funnet opp løkker som kan gjøre dette for oss! Koden under løser problemet vi skulle løse på bare to linjer:</p> <pre><code class=python><span class=hljs-keyword>for</span> i <span class=hljs-keyword>in</span> range(<span class=hljs-number>100</span>):\n    print(i, <span class=hljs-string>"Hello  world!"</span>)\n</code></pre> <p>Lurt, ikke sant?</p> </section> <section class=protip id=range> <h1 class=protip id=range>Range()</h1> <p>Range-funksjonen er svært nytting når vi skal jobbe med løkker i Python. Når du skriver <code>range(10)</code> får du en liste med tallene 0, 1, 2, 3, 4, 5, 6, 7, 8, 9. Range kan også ta inn flere parametre. Skriver du <code>range(4, 6)</code>, får du en liste med tallene fra 4 til (ikke med) 6, og hvis du skriver <code>range(6, 4, -1)</code> får du de samme tallene i motsatt rekkefølge.</p> </section> <section class=activity id=telle-til-10> <h1 class=activity id=telle-til-10>Telle til 10</h1> <p>Bruk en for-løkke til å skrive ut alle tallene mellom 0 og 10.</p> </section> <section class=activity id=liftoff> <h1 class=activity id=liftoff>Liftoff</h1> <ul class=task-list> <li class=task-list-item><input type=checkbox id=cbx_0><label for=cbx_0> Bruk en for-løkke og range-funksjonen for å telle ned fra 10. Når du kommer til 0, skal programmet skrive <strong>liftoff!</strong></label></li> </ul> <figure><img src='+n(3474)+' alt="" title="program som teller ned til liftoff"></figure> </section> <section class=activity id=summere-100-tall> <h1 class=activity id=summere-100-tall>Summere 100 tall</h1> <p>Et vanlig problem i matematikk er å summere sammen en rekke med tall. Dette er veldig lett når man kan programmere! Lag en for-løkke som går fra 0 til 100, som legger sammen alle tallene før den skriver ut resultatet. Svaret skal bli 5050.</p> </section> <section class=activity id=summere-n-tall> <h1 class=activity id=summere-n-tall>Summere n tall</h1> <ul class=task-list> <li class=task-list-item><input type=checkbox id=cbx_1><label for=cbx_1> Lag en funksjon <code>summer(n)</code>, som tar inn en parameter og returnerer summen av alle tallene fra 0 til <code>n</code>. Definer funksjonen slik:</label></li> </ul> <pre><code class=python><span class=hljs-function><span class=hljs-keyword>def</span> <span class=hljs-title>summer</span><span class=hljs-params>(n)</span>:</span>\n    sum = <span class=hljs-number>0</span>\n    <span class=hljs-comment># Din kode</span>\n    <span class=hljs-keyword>return</span> sum\n</code></pre> <p>Når koden din er rett, skal den fungere slik som dette:</p> <figure><img src='+n(3475)+' alt="" title="summering av tallrekker med python"></figure> </section> '},3474:function(e,s,n){e.exports=n.p+"_/oppgaver/src/python/regn_med_lokker/liftoff.b9310f.png"},3475:function(e,s,n){e.exports=n.p+"_/oppgaver/src/python/regn_med_lokker/summer.f48268.png"}});