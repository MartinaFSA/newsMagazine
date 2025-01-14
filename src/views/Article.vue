<template>
  <article>
    <section id="article_header">
      <div class="ctn_subtitle">
          <div>// {{this.article.type}}</div>
          <div>{{ this.article.tags  }}</div>
      </div>
      <div id="ctn_article"><h1>{{this.article.title}}</h1></div>
      <div class="title_authorArtist">
        <p>Por <span>{{ this.article.authors }}</span></p>
        <p id="separator">//</p>
        <p>Arte <span>{{ this.article.artist }}</span></p>
      </div>
      <div id="coverImg">
        <img :src="'../src/assets/images/article/' + this.article.id + '/cover.jpg'" :alt="this.article.coverImg">
      </div>
      <div id="articleDate">
        <p>{{ this.article.date }}</p>
      </div>
    </section>
    <section id="contents">
      <summary id="summary">
        <p>{{ this.article.summary }}</p>
      </summary>
      <div id="content_body"></div>
      <div id="goToTop">
        <a href="#article_header"><img src="../assets/arrowUpIcon.svg" alt="">Ir arriba</a>
      </div>
    </section>
    <section id="share">
      <div>
        <div>
          <p>¿Te gustó este artículo?</p>
          <p>¡Compartilo!</p>
        </div>
        <div>
          <a href="https://twitter.com/home?lang=es"><img src="../assets/twitterIcon.svg" alt="Twitter" srcset=""></a>
          <a href="https://www.instagram.com/"><img src="../assets/instagramIcon.svg" alt="Instagram" srcset=""></a>
          <a href="https://www.facebook.com/?locale=es_LA"><img src="../assets/facebookIcon.svg" alt="Facebook" srcset=""></a>
        </div>
        <button @click="copyAdress()">Copiar Link</button>
      </div>
    </section>
    <section>
        <div class="ctn_subtitleSecondType">
            <div>
                <p> // Contenido relacionado</p>
            </div>
        </div>
        <div v-if="this.article.category">
          <ArticlePreview :amountProp="4" :filterProp="this.article.category"></ArticlePreview>
        </div>
    </section>
  </article>
</template>

<script>
import axios from 'axios';
import ArticlePreview from '@/components/Article_Preview.vue';

export default {
  data() {
    return {
      article: []
    }
  },
  components: {
    ArticlePreview
  },
  async created() {
    let apiBaseUrl = "https://api-newsmagazine.000webhostapp.com/api/public/";
    let articleId = window.location.pathname.split("/").pop();
    await axios.get(apiBaseUrl + 'articles.php/byId/' + articleId)
        .then(response => (this.article = response.data[0])
        )
        .catch(function (error) {
            console.log(error);
        });

    document.getElementById("content_body").innerHTML = this.article.body;
  },
  methods: {
    copyAdress() {
      let link = window.location.href;
      navigator.clipboard.writeText(link);
    }
  }
}
</script>

<style scoped>
@import '@/assets/styles/article.css';
</style>