import{d as m,o as l,a as d,b as n,w as o,f as s,t as f,O as h,h as $,n as C,p as x,y as p,s as c,r as y,z as k,K as w,Y as q,F as v,g as b,B as _,A as z,u as B,Z as I,E as T}from"./entry.b607c7b4.js";import{_ as E}from"./PageHeader.e435a699.js";const N={class:"carousel-item-content"},S=["src","alt"],A={class:"h-100 w-100 d-flex flex-column"},D=["textContent"],F={class:"content"},L=m({__name:"CarouselItemContent",props:{title:{},to:{},button:{},image:{}},setup(g){return(e,u)=>{const a=C,i=E,t=x;return l(),d("div",N,[n(t,null,{default:o(()=>[n(a,{xl:"3",lg:"4",md:"5",width:"12",class:"offset-xl-3 offset-lg-2 offset-md-1 d-flex align-items-center"},{default:o(()=>[s("img",{src:e.image,alt:e.title},null,8,S)]),_:1}),n(a,{xl:"3",lg:"4",md:"5",width:"12",class:"d-flex align-items-center"},{default:o(()=>[s("div",A,[s("h3",{textContent:f(e.title)},null,8,D),s("div",F,[h(e.$slots,"default",{},void 0,!0)]),n(i,{variant:"white",to:e.to,class:"btn"},{default:o(()=>[$(f(e.button),1)]),_:1},8,["to"])])]),_:3})]),_:3})])}}});const M=p(L,[["__scopeId","data-v-e23d4a69"]]),V={class:"carousel-indicators"},G=["data-bs-slide-to","aria-label"],H={class:"carousel-inner"},P=["innerHTML"],K=m({__name:"Carousel",setup(g){const e=[{title:`C'est quoi ${c.name} ?`,image:"/img/carousel/summary.svg",button:"Accéder à la liste des cours",to:"/cours/",content:`
            <p>
                <q>Bac-o-math-iques</q> (ou plus simplement <strong>${c.name}</strong>) est un petit site web
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
                ${c.name} vous permet de les télécharger au format PDF, de les imprimer, de les partager, ...
            </p>
            <p>
                De plus, <em>très bientôt</em>, ${c.name} vous proposera des exercices complets pour vous
                permettre de vous exercer au mieux sur les différents chapitres !
            </p>`}],u=y();return k(async()=>{await w();const a=q().$bootstrap.carousel;new a(u.value)}),(a,i)=>(l(),d("div",{id:"page-carousel",ref_key:"root",ref:u,class:"carousel carousel-dark slide stripes","data-bs-ride":"carousel"},[s("div",V,[(l(),d(v,null,b(e,(t,r)=>s("button",{key:`carousel-indicator-${r}`,type:"button","data-bs-target":"#page-carousel","data-bs-slide-to":r,class:_(["carousel-indicator",{active:r===0}]),"aria-current":"true","aria-label":t.title},null,10,G)),64))]),s("div",H,[(l(),d(v,null,b(e,(t,r)=>s("div",{key:`slide-item-${r}`,class:_(["carousel-item",{active:r===0}]),"data-bs-interval":"5000"},[n(M,{class:"content",image:t.image,title:t.title,to:t.to,button:t.button},{default:o(()=>[s("div",{innerHTML:t.content},null,8,P)]),_:2},1032,["image","title","to","button"])],2)),64))])],512))}});const Z=p(K,[["__scopeId","data-v-2dd212fc"]]),O=m({__name:"CardColumn",props:{to:{default:void 0},blue:{type:Boolean,default:!1},size:{},mb:{default:0},image:{default:void 0}},setup(g){return(e,u)=>{const a=T,i=C;return l(),z(i,{class:_(`mb-xl-${e.mb}`),width:"12",lg:(e.size+1).toString(),xl:e.size.toString()},{default:o(()=>[n(a,{class:"link",to:e.to},{default:o(()=>[n(B(I),{image:e.image,class:"h-100",blue:e.blue},{default:o(()=>[h(e.$slots,"default",{},void 0,!0)]),_:3},8,["image","blue"])]),_:3},8,["to"])]),_:3},8,["class","lg","xl"])}}});const j=p(O,[["__scopeId","data-v-2694c9e5"]]);export{Z as C,j as a};
