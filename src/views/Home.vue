<template>
  <div>
    <div id="nav">
      <select v-model="selected">
        <option
          v-for="(item, idx) in list"
          :key="`dictList${idx}`"
          :value="item.value"
        >{{item.label}}</option>
      </select>
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
      selected: 'cambZh',
      list: [
        { label: 'cambridge 中文', value: 'cambZh' },
        { label: 'cambridge 英文', value: 'cambEn' },
        { label: 'DeepL', value: 'deepl' },
        { label: '英漢字典', value: 'dict' },
        // { label: '國家教育研究院', value: 'naer' },
      ],
      englishUrl: {
        deepl: 'https://cn.linguee.com/中文-英语/search?source=英语&query={text}',
        dict: 'https://cdict.net/?q={text}',
        // naer: 'http://terms.naer.edu.tw/search/?q={text}',
        cambZh: 'https://dictionary.cambridge.org/zht/詞典/英語-漢語-繁體/{text}',
        cambEn: 'https://dictionary.cambridge.org/zht/詞典/英語/{text}',
      },
    };
  },
  computed: {
    englishKey() {
      return Object.keys(this.english);
    },
  },
  methods: {
    search(t) {
      const text = t.replace(/\s/g, '+');
      const iframe = document.getElementsByTagName('iframe')[0];
      const url = this.englishUrl[this.selected].replace(/\{text\}/g, text);
      iframe.src = url;
    },
  },
};
</script>
<style lang="scss">
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
@media (max-width: 910px) {
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
</style>
