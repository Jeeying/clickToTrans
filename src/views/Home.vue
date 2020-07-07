<template>
  <div>
    <div id="nav">
      <button @click="toggleLang()">切換英語詞典/英漢詞典</button>
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
    },
    search(text) {
      const iframe = document.getElementsByTagName('iframe')[0];
      const url = 'https://dictionary.cambridge.org';
      const pos = 'zht';
      const dict = '詞典';
      iframe.src = `${url}/${pos}/${dict}/${this.langs[this.langTarget]}/${text}`;
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
.home {
  position: relative;
  display: flex;
  .english-text {
    flex: 0.61;
    font-family: Monaco, "Bitstream Vera Sans Mono", "Lucida Console", Terminal,
      monospace;
    font-size: 1rem;
    line-height: 1.4;
    padding: 0.5rem;
  }
  iframe {
    flex: 0.39;
    background-color: #fff;
  }
}
@media (max-width: 760px) {
  button {
    position: fixed;
    bottom: 60.3vh;
    z-index: 1;
    right: 0;
  }
  .home {
    .english-text {
      flex: auto;
      padding-bottom: 60vh;
    }
    iframe {
      position: fixed;
      bottom: 0;
      width: 100%;
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
