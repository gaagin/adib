(function(root){
  'use strict';

  const mono=()=>performance.now();
  const deviceTimeZone=()=>{try{return Intl.DateTimeFormat().resolvedOptions().timeZone||'Asia/Baku'}catch{return 'Asia/Baku'}};
  let timeZone=deviceTimeZone();
  let lastDay='';
  let lastZone=timeZone;
  const state={trusted:true,timeZone,source:'device',policy:'device-clock'};
  const ready=Promise.resolve(state);

  function now(){return Date.now();}
  function date(){timeZone=deviceTimeZone();return new root.ADIBZone.ZonedDate(now(),timeZone);}
  function report(){const current=date();return [
    'ADIB Online 1.1.42 — vaxt cihazdan alınır',
    'Cari vaxt: '+current.toLocaleString('az-AZ'),
    'Saat qurşağı: '+timeZone,
    'Mənbə: bu cihaz',
    'Cihazın tarixi, saatı və saat qurşağı istifadə olunur.'
  ].join('\n');}
  function details(){
    const dialog=document.createElement('dialog');
    dialog.className='adib-clock-dialog';
    const title=document.createElement('h2');
    title.textContent='Cihaz vaxtı';
    const text=document.createElement('textarea');
    text.readOnly=true;
    text.value=report();
    const close=document.createElement('button');
    close.textContent='Bağla';
    close.onclick=()=>{dialog.close();dialog.remove();};
    dialog.append(title,text,close);
    dialog.oncancel=()=>dialog.remove();
    document.body.append(dialog);
    dialog.showModal();
  }
  function notice(){
    document.getElementById('adibClockNotice')?.remove();
    document.getElementById('adibTimeWait')?.remove();
  }
  function refresh(){
    const nextZone=deviceTimeZone();
    const current=new root.ADIBZone.ZonedDate(now(),nextZone);
    if(nextZone!==lastZone||lastDay&&current.toDateString()!==lastDay){
      root.dispatchEvent(new Event('adib-clock-change'));
    }
    timeZone=nextZone;
    lastZone=nextZone;
    lastDay=current.toDateString();
    state.timeZone=timeZone;
    return Promise.resolve({...state,now:now(),checkedAt:new Date().toISOString()});
  }

  root.ADIBClock={
    now,
    date,
    stamp:now,
    elapsed:mono,
    ready,
    refresh,
    details,
    report,
    attach:notice,
    fromSystemTimestamp:value=>new root.ADIBZone.ZonedDate(Number(value),timeZone),
    get trusted(){return true;},
    get timeZone(){return timeZone=deviceTimeZone();},
    get state(){return {...state,trusted:true,timeZone:deviceTimeZone()};}
  };

  notice();
  root.addEventListener('DOMContentLoaded',notice);
  root.addEventListener('adib-home-data',notice);
  setInterval(()=>{void refresh();},15000);
})(window);