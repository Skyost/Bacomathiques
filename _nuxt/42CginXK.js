import{_ as pe,a as _e}from"./C4byHI5M.js";import{d as C,r as $,q as V,s as E,u as e,o as f,x as T,w as m,a,e as u,t as M,g as k,y as P,j as L,H as F,v as K,V as U,l as O,m as R,n as x,z as H,c as b,F as z,f as N,A as oe,i as q,C as se,D as fe,E as ne,G as he,I as ae,J as le,K as B,L as ve,M as re,N as W,O as D,Q as X,R as Y,h as ge,_ as ie,S as ce,T as J,U as be,b as ye,W as $e,P as we}from"./BRoMSsP6.js";import{u as ke}from"./BEYPaFe7.js";import{_ as Se,s as Ce}from"./DTKncP4i.js";import j from"./DOTd-_5T.js";import{P as Ie}from"./BRvOvM12.js";import{u as ee,q as te}from"./BGnsZgT2.js";import{s as xe}from"./CQIgKE_L.js";const ue=i=>(O("data-v-f8fbab2c"),i=i(),R(),i),Le=ue(()=>u("img",{src:Se,alt:"Logo",class:"w-100"},null,-1)),Ae=["textContent"],Te=ue(()=>u("span",{class:"info info-author"},"Skyost",-1)),Me={class:"info info-price"},He=C({__name:"SmartBannerContent",props:{mobileOs:{}},emits:["close"],setup(i,{emit:t}){const d=i,o=t,n=$(null);V(()=>{switch(d.mobileOs){case"Android":n.value={name:"Sur Google Play",link:E.mobile.googlePlay,bannerClass:"smartbanner-android"};break;case"iOS":n.value={name:"Sur l'App Store",link:E.mobile.appStore,bannerClass:"smartbanner-ios"};break}});const c=()=>{n.value=null,o("close")};return(h,v)=>{const l=F,g=K,y=U;return e(n)?(f(),T(y,{key:0,class:P(["smartbanner",e(n).bannerClass])},{default:m(()=>[a(l,{cols:"1",class:"d-flex align-items-center"},{default:m(()=>[u("span",{class:"smartbanner-close",onClick:c},"×")]),_:1}),a(l,{cols:"3",class:"d-flex align-items-center"},{default:m(()=>[Le]),_:1}),a(l,{cols:"5",class:"d-flex align-items-center"},{default:m(()=>[u("div",null,[u("span",{class:"info info-title",textContent:M(e(E).name)},null,8,Ae),Te,u("span",Me,"GRATUIT - "+M(e(n).name),1)])]),_:1}),a(l,{cols:"3",class:"d-flex align-items-center"},{default:m(()=>[a(g,{href:e(n).link,target:"_blank",variant:"green",block:""},{default:m(()=>[k(" VOIR ")]),_:1},8,["href"])]),_:1})]),_:1},8,["class"])):L("",!0)}}}),Ee=x(He,[["__scopeId","data-v-f8fbab2c"]]),Pe=C({__name:"SmartBanner",setup(i){let t=new Date;t=new Date(t.setMonth(t.getMonth()+6));const d=ke("smartbanner_closed",{path:"/",expires:t}),o=H(()=>{{const c=navigator.userAgent||navigator.vendor||window.opera;if(/android/i.test(c))return"Android";if(/iPad|iPhone|iPod/.test(c)&&!window.MSStream)return"iOS"}return"unknown"}),n=()=>{d.value="true"};return(c,h)=>e(d)?L("",!0):(f(),T(e(Ee),{key:0,"mobile-os":e(o),onClose:n},null,8,["mobile-os"]))}}),Oe=C({__name:"LessonHeaderDifficulty",props:{difficulty:{}},setup(i){const t=i,d=H(()=>{switch(t.difficulty){case 1:return"Facile";case 2:return"Modéré";case 3:return"Moyen";case 4:return"Difficile";case 5:default:return"Complexe"}});return(o,n)=>{const c=j;return f(),b("span",{class:P(`lesson-info difficulties level-${o.difficulty}`),title:"Difficulté du cours"},[(f(),b(z,null,N(5,h=>a(c,{key:h,name:"bi:pencil-fill",class:P({colored:h<=o.difficulty})},null,8,["class"])),64)),k(" "+M(e(d)),1)],2)}}}),Re=x(Oe,[["__scopeId","data-v-168699ae"]]),De=["src","alt","title"],Be=C({__name:"LessonHeaderOption",props:{id:{},title:{}},setup(i){return(t,d)=>(f(),b("img",{class:"option",src:`/img/lessons/${t.id}.svg`,alt:t.title,title:t.title},null,8,De))}}),Q=x(Be,[["__scopeId","data-v-97bd1dac"]]),Ve=["href"],Fe=C({__name:"PdfOption",props:{lesson:{}},setup(i){return(t,d)=>(f(),b("a",{href:t.lesson.pdf,target:"_blank"},[a(Q,{id:"pdf",title:"Télécharger le PDF"})],8,Ve))}}),Ue=i=>(O("data-v-df700086"),i=i(),R(),i),ze={class:"d-inline-block"},Ne={class:"list-group text-start mb-4"},qe=["href"],je=["href"],Ge=["href"],We=Ue(()=>u("p",null,"Sinon, vous pouvez directement copier le lien vers ce cours dans votre presse-papier :",-1)),Je=["value"],Ke=C({__name:"ShareOption",props:{lesson:{}},setup(i){const t=$(!1),d=oe(),o=H(()=>E.host+d.fullPath);return(n,c)=>{const h=j,v=se;return f(),b("div",ze,[a(Q,{id:"share",title:"Partager le cours",onClick:c[0]||(c[0]=l=>t.value=!e(t))}),a(v,{id:"modal-share",modelValue:e(t),"onUpdate:modelValue":c[1]||(c[1]=l=>q(t)?t.value=l:null),title:"Partager le cours",size:"lg","ok-variant":"secondary","ok-title":"Fermer","ok-only":""},{default:m(()=>[u("div",Ne,[u("a",{class:"list-group-item list-group-item-action text-decoration-none",href:`https://twitter.com/intent/tweet?text=Retrouvez%20le%20cours%20intitul%C3%A9%20%22${encodeURI(n.lesson.title)}%22%20sur%20${encodeURI(e(E).name)}%20!&url=${encodeURI(e(o))}`,target:"_blank"},[a(h,{name:"bi:twitter"}),k(" Partager sur Twitter ")],8,qe),u("a",{class:"list-group-item list-group-item-action text-decoration-none",href:`https://www.facebook.com/sharer/sharer.php?u=${encodeURI(e(o))}&t=`,target:"_blank"},[a(h,{name:"bi:facebook"}),k(" Partager sur Facebook ")],8,je),u("a",{class:"list-group-item list-group-item-action text-decoration-none",href:`mailto:?subject=&body=Retrouvez%20le%20cours%20intitul%C3%A9%20%22${encodeURI(n.lesson.title)}%22%20sur%20${encodeURI(e(E).name)}%20!%20${encodeURI(e(o))}`,target:"_blank"},[a(h,{name:"bi:envelope-fill"}),k(" Partager par Email ")],8,Ge)]),We,u("input",{class:"form-control w-100",type:"text",value:e(o),readonly:""},null,8,Je)]),_:1},8,["modelValue"])])}}}),Qe=x(Ke,[["__scopeId","data-v-df700086"]]),Ze=i=>(O("data-v-9f981fc1"),i=i(),R(),i),Xe={class:"d-inline-block"},Ye=Ze(()=>u("p",null,"Pour apporter une correction à un cours, vous avez deux solutions :",-1)),et={class:"list-group text-start mb-4"},tt=["href"],ot=C({__name:"CaveatOption",props:{lesson:{}},setup(i){const t=$(!1),d=`https://github.com/${E.github.username}/${E.github.repository}`;return(o,n)=>{const c=j,h=fe,v=se;return f(),b("div",Xe,[a(Q,{id:"caveat",title:"Signaler une erreur",onClick:n[0]||(n[0]=l=>t.value=!e(t))}),a(v,{id:"modal-caveat",modelValue:e(t),"onUpdate:modelValue":n[1]||(n[1]=l=>q(t)?t.value=l:null),title:"Signaler une erreur",size:"lg","ok-variant":"secondary","ok-title":"Fermer","ok-only":""},{default:m(()=>[Ye,u("div",et,[a(h,{class:"list-group-item list-group-item-action text-decoration-none",to:"/a-propos/#contact"},{default:m(()=>[a(c,{name:"bi:envelope-fill"}),k(" Me contacter ")]),_:1}),u("a",{class:"list-group-item list-group-item-action text-decoration-none",href:`${d}/edit/master/content/latex/lessons/${o.lesson.level}/${o.lesson.id}.tex`},[a(c,{name:"bi:github"}),k(" Modifier le code source de la page ")],8,tt)])]),_:1},8,["modelValue"])])}}}),st=x(ot,[["__scopeId","data-v-9f981fc1"]]),de=i=>(O("data-v-b325ebd3"),i=i(),R(),i),nt={id:"lesson-header"},at=["textContent"],lt={key:0,class:"lesson-subtitle"},rt={class:"lesson-info level",title:"Niveau du cours"},it=["src","alt"],ct=["innerHTML"],ut=de(()=>u("strong",null,"Plus d'options",-1)),dt=de(()=>u("span",{class:"hint"},"Télécharger le PDF, partager, ...",-1)),mt=C({__name:"LessonHeaderContent",props:{lesson:{},isSummary:{type:Boolean,default:!1}},setup(i){const t=i,d=$(!1),o=H(()=>ne[t.lesson.level]),n=H(()=>he(t.lesson));return(c,h)=>{const v=Re,l=K,g=F,y=U;return f(),b("div",nt,[u("h3",{textContent:M(e(n))},null,8,at),c.isSummary?(f(),b("h4",lt," Fiche résumée ")):L("",!0),u("span",rt,[u("img",{src:e(o).image,alt:e(o).name},null,8,it),k(" "+M(e(o).name),1)]),a(v,{difficulty:c.lesson.difficulty},null,8,["difficulty"]),u("p",{innerHTML:c.lesson.description},null,8,ct),c.isSummary?(f(),T(l,{key:1,class:"btn-block w-100",variant:"white",to:`/cours/${e(o).id}/${c.lesson.id}/`},{default:m(()=>[k(" Retour au cours ")]),_:1},8,["to"])):(f(),T(y,{key:2},{default:m(()=>[a(g,{cols:"12",lg:"6",class:"mb-lg-0 mb-2"},{default:m(()=>[a(l,{variant:"white",class:"btn d-flex justify-content-center align-items-center fw-bold",to:`/cours/${e(o).id}/${c.lesson.id}/resume/`},{default:m(()=>[k(" Lire le résumé ")]),_:1},8,["to"])]),_:1}),a(g,{cols:"12",lg:"6"},{default:m(()=>[a(l,{variant:"white",class:"btn",onClick:h[0]||(h[0]=S=>d.value=!e(d))},{default:m(()=>[ut,dt]),_:1})]),_:1}),a(g,{lg:"12",class:P(["options",{expanded:e(d)}])},{default:m(()=>[a(Fe,{lesson:c.lesson},null,8,["lesson"]),a(Qe,{lesson:c.lesson},null,8,["lesson"]),a(st,{lesson:c.lesson},null,8,["lesson"])]),_:1},8,["class"])]),_:1}))])}}}),pt=x(mt,[["__scopeId","data-v-b325ebd3"]]),_t=C({__name:"LessonHeader",props:{lesson:{},isSummary:{type:Boolean,default:!1}},setup(i){const t=$(null);ae(()=>window.addEventListener("resize",d)),le(()=>window.removeEventListener("resize",d)),V(async()=>{await B(),d()});const d=()=>{t.value&&(t.value.style.height=`${t.value.offsetWidth}px`)};return(o,n)=>{const c=pt,h=pe;return f(),T(h,{ref:"root",image:o.lesson.preview},{image:m(()=>[u("span",{ref_key:"headerImage",ref:t,class:"header-image ms-auto me-auto ms-md-0 me-md-0",style:ve(`background-image: url('${o.lesson.preview}');`)},null,4)]),default:m(()=>[a(c,{lesson:o.lesson,"is-summary":o.isSummary},null,8,["lesson","is-summary"])]),_:1},8,["image"])}}}),ft=x(_t,[["__scopeId","data-v-d1ac8260"]]);var ht=vt;function vt(i,t,d){var o=null,n=null,c=function(){o&&(clearTimeout(o),n=null,o=null)},h=function(){var l=n;c(),l&&l()},v=function(){if(!t)return i.apply(this,arguments);var l=this,g=arguments,y=d&&!o;if(c(),n=function(){i.apply(l,g)},o=setTimeout(function(){if(o=null,!y){var S=n;return n=null,S()}},t),y)return n()};return v.cancel=c,v.flush=h,v}const Z=i=>(O("data-v-b446a83d"),i=i(),R(),i),gt=["method"],bt=Z(()=>u("input",{name:"client",type:"hidden",value:"bacomathiqu.es"},null,-1)),yt={class:"position-relative mb-3"},$t=["src"],wt={key:0},kt=Z(()=>u("a",{href:"https://akismet.com/privacy/"},"Politique de confidentialité",-1)),St=Z(()=>u("a",{href:"https://akismet.com/tos/"},"Conditions d'utilisation",-1)),Ct={key:1,class:"alert alert-success"},It={key:2,class:"alert alert-danger"},xt=C({__name:"CommentForm",setup(i){const t=$(!1),d=$(null),o=$(null),n=$(""),c=$(""),h=$("POST"),v=$(null),l=$(void 0),g=$(),y=$(),S=async p=>{d.value=null,o.value=null,t.value=!0;try{const _=p.target,s=new FormData(_);let r="";s.forEach(function(A,I){r+=encodeURIComponent(I.toString())+"="+encodeURIComponent(A.toString())+"&"}),r.length>0&&(r=r.substring(0,r.length-1));const w=await fetch(_.action,{method:_.method,body:r,headers:{"Content-Type":"application/x-www-form-urlencoded"}});o.value=!w.ok,d.value=!o.value}catch{o.value=!0}t.value=!1};return re(n,p=>{v.value&&v.value.cancel();const _=ht(()=>{l.value=W(p),v.value=null},300);v.value=_,_()}),V(async()=>{l.value=W(n.value),await B(),y.value.style.height=`${g.value.offsetHeight}px`,g.value.style.paddingLeft=`${g.value.offsetHeight+6}px`}),(p,_)=>{const s=j,r=K,w=F,A=U;return f(),b("div",null,[D(p.$slots,"title",{},void 0,!0),u("form",{class:"comment-form",action:"https://vercel.bacomathiqu.es/api/post-comment",method:e(h),onSubmit:ge(S,["prevent"])},[D(p.$slots,"inputs",{},void 0,!0),bt,X(u("textarea",{"onUpdate:modelValue":_[0]||(_[0]=I=>q(c)?c.value=I:null),class:"form-control mb-3",name:"message",rows:"5",placeholder:"Exprimez-vous !",required:""},null,512),[[Y,e(c)]]),u("div",yt,[u("img",{ref_key:"avatarImageElement",ref:y,src:e(l),alt:"Avatar (prévisualisation)",title:"Avatar (prévisualisation)",class:"comment-avatar"},null,8,$t),X(u("input",{ref_key:"avatarInputElement",ref:g,"onUpdate:modelValue":_[1]||(_[1]=I=>q(n)?n.value=I:null),type:"text",class:"comment-author form-control",name:"author",placeholder:"Nom d'utilisateur",required:""},null,512),[[Y,e(n)]])]),a(A,null,{default:m(()=>[a(w,{xs:"12",sm:"6",md:"3"},{default:m(()=>[a(r,{variant:"white",type:"submit",class:"d-block w-100",disabled:e(t)===!0||e(d)===!0},{default:m(()=>[a(s,{name:"bi:send-fill"}),k(" Envoyer ")]),_:1},8,["disabled"])]),_:1}),a(w,{xs:"12",sm:"6",md:"9",class:P(["mt-2 mt-0-lg text-end",{"align-items-center":e(d)||e(o)}])},{default:m(()=>[!e(d)&&!e(o)?(f(),b("small",wt,[a(s,{name:"bi:incognito"}),k(" Protégé par Akismet ("),kt,k(" & "),St,k("). ")])):L("",!0),e(d)?(f(),b("div",Ct,[a(s,{name:"bi:check",class:"me-2"}),k(" Votre commentaire a été envoyé avec succès. Veuillez cependant noter qu'il ne sera publié qu'après modération 😉 ")])):L("",!0),e(o)?(f(),b("div",It,[a(s,{name:"bi:exclamation-circle-fill",class:"me-2"}),k(" Impossible de poster votre commentaire. Veuillez réessayer plus tard. ")])):L("",!0)]),_:1},8,["class"])]),_:1})],40,gt)])}}}),Lt=x(xt,[["__scopeId","data-v-b446a83d"]]),At=["href"],Tt=["src","alt"],Mt=["id"],Ht={key:0,class:"badge bg-info"},Et=["textContent"],Pt={class:"d-block text-right text-muted"},Ot=C({__name:"CommentCard",props:{comment:{}},setup(i){const t=i,d=H(()=>new Date(t.comment.date*1e3)),o=H(()=>d.value.toLocaleDateString("fr-FR")),n=H(()=>d.value.toLocaleTimeString("fr-FR")),c=H(()=>W(t.comment.author));return(h,v)=>{const l=F,g=U;return f(),T(ie,{class:"comment"},{default:m(()=>[a(g,null,{default:m(()=>[a(l,{cols:"12",lg:"3",class:"mb-lg-0 mb-4"},{default:m(()=>[u("a",{href:`#commentaire-${h.comment._id}`},[u("img",{src:e(c),alt:h.comment.author,class:"avatar"},null,8,Tt)],8,At)]),_:1}),a(l,{cols:"12",lg:"9",class:"content"},{default:m(()=>[u("h3",{id:`commentaire-${h.comment._id}`},[k(M(h.comment.author)+" ",1),e(E).moderators.includes(h.comment.author)?(f(),b("span",Ht," Modérateur ")):L("",!0)],8,Mt),u("p",{class:"mb-4",textContent:M(h.comment.message)},null,8,Et),u("small",Pt,M(e(o))+" "+M(e(n)),1)]),_:1})]),_:1})]),_:1})}}}),Rt=x(Ot,[["__scopeId","data-v-b61434b2"]]),Dt=["href","innerHTML"],Bt=["href","innerHTML"],Vt=C({__name:"Navigation",props:{toc:{},navbarShrinkedHeight:{default:Ce}},setup(i){const t=i,d=$(null),o=$(null),n=$([]),c=$(0),h=$(null);re(c,p=>{const _=g(p,n.value);_!=null&&(o.value=_)}),V(async()=>{await B(),v(),o.value=n.value[0],await B(),h.value=new ResizeObserver(v),h.value.observe(document.body),d.value.style.top=`${t.navbarShrinkedHeight}px`}),ae(()=>{window.addEventListener("scroll",y)}),le(()=>{var p;window.removeEventListener("scroll",y),(p=h.value)==null||p.disconnect()});const v=()=>{n.value=t.toc.map(p=>l(p))},l=(p,_=null)=>{p.depth===2&&(_=p.id);const s={id:p.id,html:p.text,children:[],topOffset:-1,section:_},r=document.getElementById(p.id);if(r){const w=r.cloneNode(!0),A=w.querySelector(".anchor");A&&w.removeChild(A),s.html=w.innerHTML,s.topOffset=S(r)-r.offsetHeight}for(const w of p.children)s.children.push(l(w,_));return s},g=(p,_)=>{let s=null;for(const r of _){if(p<r.topOffset)break;s=g(p,r.children)??r}return s},y=()=>{c.value=document.documentElement.scrollTop},S=p=>{let _=0,s=p;do _+=s.offsetTop||0,s=s.offsetParent;while(s);return _};return(p,_)=>e(o)?(f(),b("nav",{key:0,ref_key:"root",ref:d,class:"lesson-navigation"},[(f(!0),b(z,null,N(e(n),s=>(f(),b("div",{key:s.id},[u("a",{href:`#${s.id}`,class:P(["entry parent",{active:s.id===e(o).id}]),innerHTML:s.html},null,10,Dt),s.children.length>0?(f(),b("ul",{key:0,ref_for:!0,ref:s.section,class:P(["collapse children",{show:e(o).section===s.section}])},[(f(!0),b(z,null,N(s.children,r=>(f(),b("li",{key:r.id},[u("a",{href:`#${r.id}`,class:P(["entry child",{active:r.id===e(o).id}]),innerHTML:r.html},null,10,Bt)]))),128))],2)):L("",!0)]))),128))],512)):L("",!0)}}),Ft=x(Vt,[["__scopeId","data-v-7955d8e0"]]),Ut={key:0,class:"pt-5 pb-5"},zt={key:0,class:"pt-5"},Nt={key:1,class:"text-muted text-center d-block pt-5 pb-5"},qt=C({__name:"MathDocument",props:{comments:{},toc:{},ads:{type:Boolean}},setup(i){const t=i,o=ce().public.debug,n=$(null),c=l=>{switch(l){case"proof":return"Démonstration";case"correction":return"Correction";default:return null}},h=()=>{var p,_;const l=n.value.querySelectorAll("table");for(const s of l){s.classList.add("table","table-bordered","table-hover");const r=s.parentNode,w=document.createElement("div");w.classList.add("table-responsive"),r.replaceChild(w,s),w.appendChild(s)}const g=n.value.querySelectorAll("h2, h3, h4");for(const s of g){if(t.ads&&s.tagName==="H2"){const r=document.createElement("ins");r.setAttribute("data-ad-client",o?"ca-google":"ca-pub-7167241518798106"),r.setAttribute("data-ad-slot","4882057404"),r.setAttribute("data-ad-format","auto"),r.setAttribute("data-full-width-responsive","true"),r.setAttribute("data-adtest",o?"on":"null"),(p=s.parentNode)==null||p.insertBefore(r,s)}if(s.id){const r=document.createElement("a");r.setAttribute("href",`#${s.id}`),r.classList.add("anchor"),s.appendChild(r)}}const y=n.value.querySelectorAll(".bubble");for(let s=0;s<y.length;s++){const r=y[s];if(!c(r.getAttribute("data-variant")))continue;const A=r.getAttribute("id");r.removeAttribute("id");const I=document.createElement("details");I.setAttribute("id",A),I.innerHTML=r.outerHTML,(_=r.parentNode)==null||_.insertBefore(I,r),r.remove();const G=document.createElement("summary");G.classList.add("bubble-collapse-label"),G.textContent="Correction",I.insertBefore(G,I.firstChild)}const S=n.value.querySelectorAll(".representation");S.length>0&&(J({script:[{src:"https://www.geogebra.org/apps/deployggb.js"}]}),v(S)),t.ads&&J({script:[{src:"https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js",async:!0},{innerHTML:(r=>`if (!window.__abg_called){ ${r} window.__abg_called = true;}`)("(window.adsbygoogle = window.adsbygoogle || []).push({});")}]})},v=l=>{if(!window.GGBApplet){setTimeout(()=>v(l),500);return}for(const g of l){g.id=g.getAttribute("data-geogebra-id"),g.classList.add("ms-auto","me-auto","mb-3","mw-100");const y=g.parentElement,S=y.getBoundingClientRect().width-parseInt(y.style.paddingLeft.toString())-parseInt(y.style.paddingRight.toString()),p=Math.min(S,800),_=window.innerWidth;let s=1;_<992&&(s=2),_<768&&(s=4),new window.GGBApplet({id:g.id,material_id:g.getAttribute("data-geogebra-id"),height:.75*p,width:p,showResetIcon:!0,enableLabelDrags:!1,scale:s,allowUpscale:!0,scaleContainerClass:"representation",preventFocus:!0,enableShiftDragZoom:!0,borderColor:"rgba(0, 0, 0, 0.5)"},!0).inject(g.id)}};return V(async()=>{await B(),h()}),(l,g)=>{const y=F,S=U,p=be;return f(),b("div",null,[a(p,{class:"mb-5",fluid:!0},{default:m(()=>[a(S,null,{default:m(()=>[a(y,{cols:"12",lg:"9",class:"ps-0 pe-0"},{default:m(()=>[u("div",{ref_key:"root",ref:n,class:"math-document"},[D(l.$slots,"default",{},void 0,!0)],512)]),_:3}),l.toc?(f(),T(y,{key:0,lg:"3",class:"d-lg-block d-none ps-0 pe-0"},{default:m(()=>[a(Ft,{toc:l.toc},null,8,["toc"])]),_:1})):L("",!0)]),_:3})]),_:3}),l.comments?(f(),b("div",Ut,[a(ie,{class:"mb-5",blue:""},{default:m(()=>[a(Lt,null,{title:m(()=>[D(l.$slots,"comments-headings",{},void 0,!0)]),inputs:m(()=>[D(l.$slots,"comments-inputs",{},void 0,!0)]),_:3})]),_:3}),l.comments.length>0?(f(),b("div",zt,[(f(!0),b(z,null,N(l.comments,_=>(f(),T(Rt,{key:_._id,class:"mb-5",comment:_},null,8,["comment"]))),128))])):(f(),b("em",Nt," Il n'y a pas de commentaire sur ce cours pour le moment. "))])):L("",!0)])}}}),jt=x(qt,[["__scopeId","data-v-83e0fd06"]]),me=i=>(O("data-v-3b62723d"),i=i(),R(),i),Gt={key:1},Wt=["innerHTML"],Jt=me(()=>u("h2",null,"Vous avez aimé ce cours ?",-1)),Kt=me(()=>u("p",null,"Faîtes-le nous savoir dans les commentaires !",-1)),Qt=["value"],Zt=["value"],Xt=C({__name:"[[slug]]",setup(i){const t=oe(),d=t.params.slug==="",o=t.params.slug==="resume",n=ne[t.params.level.toString()],{error:c,pending:h,data:v}=ee(t.path,()=>te(xe.dataLatexDirectory,t.params.level.toString(),t.params.lesson.toString()).without(d?["summary"]:["body"]).findOne(),"$3VgoNs6fOo"),{data:l}=ee(`${t.path}?comments`,()=>te("comments").where({level:t.params.level.toString(),lesson:t.params.lesson.toString()}).sort({date:-1}).find());return ce().public.debug||J({script:[{src:"/js/funding_choices.js"}]}),(y,S)=>{const p=_e,_=ye,s=Pe,r=ft,w=Ie,A=we,I=$e;return e(h)?(f(),T(p,{key:0})):(d||o)&&e(v)?(f(),b("div",Gt,[a(_,{title:`${e(n).name} > ${e(v).title}${o?" > Fiche résumée":""}`,description:e(v).description},null,8,["title","description"]),a(s),a(w,{class:"page-header"},{default:m(()=>[a(r,{level:e(n),lesson:e(v),"is-summary":o},null,8,["level","lesson"])]),_:1}),a(jt,{class:"page-lesson",comments:d?e(l):void 0,ads:!0,toc:e(v).toc},{"comments-headings":m(()=>[Jt,Kt]),"comments-inputs":m(()=>[u("input",{name:"lesson",type:"hidden",value:e(v).id},null,8,Qt),u("input",{name:"level",type:"hidden",value:e(v).level},null,8,Zt)]),default:m(()=>[a(A,{class:"page-content"},{default:m(()=>[u("div",{innerHTML:"body"in e(v)?e(v).body:e(v).summary},null,8,Wt)]),_:1})]),_:1},8,["comments","toc"])])):(f(),T(I,{key:2,error:e(c)},null,8,["error"]))}}}),ro=x(Xt,[["__scopeId","data-v-3b62723d"]]);export{ro as default};
