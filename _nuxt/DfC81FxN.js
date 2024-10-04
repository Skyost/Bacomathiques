import{d as i,o as u,c as g,a as s,w as t,e as r,t as _,O as f,g as C,H as b,v as x,V as $,n as m,s as l,x as v,f as q,F as w,a0 as k,a1 as z,u as B,a2 as T,y,D}from"./BRoMSsP6.js";const I={class:"carousel-item-content"},V=["src","alt"],E={class:"h-100 w-100 d-flex flex-column"},F=["textContent"],H={class:"content"},N=i({__name:"CarouselItemContent",props:{title:{},to:{},button:{},image:{}},setup(d){return(e,p)=>{const o=b,a=x,c=$;return u(),g("div",I,[s(c,null,{default:t(()=>[s(o,{xl:"3",lg:"4",md:"5",cols:"12",class:"offset-xl-3 offset-lg-2 offset-md-1 d-flex align-items-center"},{default:t(()=>[r("img",{src:e.image,alt:e.title},null,8,V)]),_:1}),s(o,{xl:"3",lg:"4",md:"5",cols:"12",class:"d-flex align-items-center"},{default:t(()=>[r("div",E,[r("h3",{textContent:_(e.title)},null,8,F),r("div",H,[f(e.$slots,"default",{},void 0,!0)]),s(a,{variant:"white",to:e.to,class:"btn"},{default:t(()=>[C(_(e.button),1)]),_:1},8,["to"])])]),_:3})]),_:3})])}}}),L=m(N,[["__scopeId","data-v-d8a45283"]]),S=["innerHTML"],A=i({__name:"Carousel",setup(d){const e=[{title:`C'est quoi ${l.name} ?`,image:"/img/carousel/summary.svg",button:"Accéder à la liste des cours",to:"/cours/",content:`
            <p>
                <q>Bac-o-math-iques</q> (ou plus simplement <strong>${l.name}</strong>) est un petit site web
                qui contient tout ce dont vous avez besoin pour réviser vos maths de la Première à la Terminale !
            </p>
            <p>
                Que vous cherchiez à passer votre Baccalauréat ou que vous souhaitiez simplement <strong>réviser votre
                cours</strong> :
                tout est possible et tout est gratuit.
            </p>`},{title:"Des cours clairs et précis",image:"/img/carousel/example.svg",button:"Exemple de cours",to:"/cours/terminale/suites/",content:`
            <p>
                Nous mettons un point d'orgue à écrire nos cours de la manière la plus claire et la plus précise possible.
                Tous les résultats énoncés illustrés par des exemples et par des graphiques
                <a href="https://www.geogebra.org/">GeoGebra</a>, et ceux qui ont besoin d'être démontrés le sont.
            </p>
            <p>
                Surtout, n'hésitez pas à aller voir ça de vous-même en cliquant sur le bouton ci-dessous !
            </p>`},{title:"Et bien plus encore !",image:"/img/carousel/diploma.svg",button:"Accéder à la liste des cours",to:"/cours/",content:`
            <p>
                En plus de vous proposer des cours totalement <strong>gratuits</strong> et <strong>libres d'accès</strong>,
                ${l.name} vous permet de les télécharger au format PDF, de les imprimer, de les partager, ...
            </p>
            <p>
                De plus, <em>très bientôt</em>, ${l.name} vous proposera des exercices complets pour vous
                permettre de vous exercer au mieux sur les différents chapitres !
            </p>`}];return(p,o)=>{const a=k,c=z;return u(),v(c,{id:"page-carousel",class:"carousel carousel-dark slide stripes",indicators:"",ride:"carousel",interval:"5000"},{default:t(()=>[(u(),g(w,null,q(e,(n,h)=>s(a,{key:`slide-item-${h}`,class:"carousel-item",background:"transparent"},{img:t(()=>[s(L,{class:"content",image:n.image,title:n.title,to:n.to,button:n.button},{default:t(()=>[r("div",{innerHTML:n.content},null,8,S)]),_:2},1032,["image","title","to","button"])]),_:2},1024)),64))]),_:1})}}}),P=m(A,[["__scopeId","data-v-0a0bde99"]]),G=i({__name:"CardColumn",props:{to:{default:void 0},blue:{type:Boolean,default:!1},size:{},mb:{default:0},image:{default:void 0}},setup(d){return(e,p)=>{const o=D,a=b;return u(),v(a,{class:y(`mb-xl-${e.mb}`),cols:"12",lg:e.size+1,xl:e.size},{default:t(()=>[s(o,{class:"link",to:e.to},{default:t(()=>[s(B(T),{image:e.image,class:"h-100",blue:e.blue},{default:t(()=>[f(e.$slots,"default",{},void 0,!0)]),_:3},8,["image","blue"])]),_:3},8,["to"])]),_:3},8,["class","lg","xl"])}}}),O=m(G,[["__scopeId","data-v-48e3458f"]]);export{P as C,O as a};
