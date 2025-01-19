<template>
  <section>
    <button @click="$emit('closePopUp')">Close</button>
    <article>
      <section id="article_header">
        <div class="ctn_subtitle">
            <div>// {{article.type}}</div>
            <div>{{ article.tags  }}</div>
        </div>
        <div id="ctn_article"><h1>{{article.title}}</h1></div>
        <div class="title_authorArtist">
          <p>Por <span>{{ article.writer }}</span></p>
          <p id="separator">//</p>
          <p>Arte <span>{{ article.artist }}</span></p>
        </div>
        <div id="coverImg">
          <img :src="'../src/assets/images/article/' + article.id + '/cover.jpg'" alt="">
        </div>
        <div id="articleDate">
          <p>{{ article.date }}</p>
        </div>
      </section>
      <section id="contents">
        <summary id="summary">
          <p>{{ article.summary }}</p>
        </summary>
        <div id="content_body" v-html="article.body"></div>
        <div id="goToTop">
          <a href="#article_header"><img src="../assets/arrowUpIcon.svg" alt="">Ir arriba</a>
        </div>
      </section>
    </article>
  </section>
</template>
  
<script setup lang="ts">  
  defineProps({
    article: {
      type: Object,
      required: true,
    },
  });
</script>
  
<style scoped>
  @import '@/assets/styles/article.css';
</style>