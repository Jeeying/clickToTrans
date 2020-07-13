<template>
  <div>
    <div id="nav">
      <button
        :class="urlTarget === '' ? 'active':''"
        @click="toggleLang()"
      >切換{{langs[langTarget]}}詞典</button> |
      <button
        :class="urlTarget === 'dict' ? 'active':''"
        @click="changeUrl('dict')"
      >英漢字典</button> |
      <button
        :class="urlTarget === 'naer' ? 'active':''"
        @click="changeUrl('naer')"
      >國家教育研究院</button>
    </div>
    <div class="home">
      <div class="english-text">
        <div v-for="day in englishKey" :key="day">
          <p>{{day}}</p>
          <template v-for="e in english[day]">
            <a :key="e" @click.prevent="search(e)">{{e}}</a>,
          </template>
          <p>
            <br />
          </p>
        </div>
      </div>
      <iframe
        ref="frame"
        name="frameEnglish"
        id="frame1"
        src="https://dictionary.cambridge.org/zht/%E8%A9%9E%E5%85%B8/%E8%8B%B1%E8%AA%9E-%E6%BC%A2%E8%AA%9E-%E7%B9%81%E9%AB%94/agrarian"
      ></iframe>
    </div>
  </div>
</template>

<script>
import english from '@/assets/english';

export default {
  name: 'Home',
  data() {
    return {
      english,
      langTarget: 'zh',
      langs: {
        zh: '英語-漢語-繁體',
        en: '英語',
      },
      urlTarget: '',
      url: {
        dict: 'https://cdict.net/?q=',
        naer: 'http://terms.naer.edu.tw/search/?q=',
      },
    };
  },
  computed: {
    englishKey() {
      return Object.keys(this.english);
    },
  },
  methods: {
    toggleLang() {
      this.langTarget = this.langTarget === 'zh' ? 'en' : 'zh';
      this.urlTarget = '';
    },
    changeUrl(target) {
      this.urlTarget = target;
    },
    search(t) {
      const text = t.replace(/\s/g, '+');
      const iframe = document.getElementsByTagName('iframe')[0];
      const url = 'https://dictionary.cambridge.org';
      const pos = 'zht';
      const dict = '詞典';
      if (this.urlTarget === 'dict') {
        iframe.src = `${this.url[this.urlTarget]}${text}`;
      } else if (this.urlTarget === 'naer') {
        iframe.src = `${this.url[this.urlTarget]}"${text}"`;
      } else {
        iframe.src = `${url}/${pos}/${dict}/${this.langs[this.langTarget]}/${text}`;
      }
    },
  },
};
</script>
<style lang="scss">
button {
  display: inline-block;
  padding: 0.2rem 0.5rem;
  background-color: #ccc;
}
button.active {
  background-color: #f5f5f5;
}
a:hover,
a:active,
a:focus {
  color: #53ff91;
}
.home {
  position: relative;
  .english-text {
    font-family: Monaco, "Bitstream Vera Sans Mono", "Lucida Console", Terminal,
      monospace;
    font-size: 1rem;
    line-height: 1.4;
    padding: 0.5rem;
    padding-right: 40vw;
  }
  iframe {
    background-color: #fff;
    position: fixed;
    width: 39vw;
    right: 0;
    top: 0;
    height: calc(100vh + 104px);
    margin-bottom: -104px;
  }
}
@media (max-width: 760px) {
  #nav {
    position: fixed;
    bottom: 60.3vh;
    z-index: 1;
    right: 0;
  }
  .home {
    .english-text {
      padding-right: 0px;
      padding-bottom: 60vh;
    }
    iframe {
      position: fixed;
      top: auto;
      right: auto;
      bottom: 0;
      width: 100vw;
      height: calc(60vh + 108px);
      margin-bottom: -108px;
      left: 0;
    }
  }
}

// .wrapper.mobile iframe {
//   position: fixed;
//   bottom: 0;
//   width: 100%;
//   height: 60vh;
//   left: 0;
// }
</style>
