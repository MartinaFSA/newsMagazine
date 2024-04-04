<template>
  <section v-if="this.articles[0]" id="ctn_articlesPreview">
    <RouterLink v-for="(n, index) in this.defineAmountValue()" :key="index" :to="'/article/' + this.articles[index].id" class="article_Preview" alt="Ir al artículo">
        <img :src="'../src/assets/images/article/' + this.articles[index].id + '/cover.jpg'" :alt="this.articles[index].coverImg">
        <div>
          <p class="tags">{{this.articles[index].tags}}</p>
          <p class="title">{{this.articles[index].title}}</p>
        </div>
    </RouterLink>
  </section>
</template>

<script>
export default {
  props: {
    amountProp: {
      type: Number,
    },
    filterProp: {
      type: String,
      default: "all"
    }
  },
  data() {
    return {
      articles: []
    }
  },
  async created() {
    if (this.filterProp === 'all') {
      await axios.get('http://localhost/api/articles.php/allArticles')
        .then(response => (this.articles = response.data)
        )
        .catch(function (error) {
            console.log(error);
        });
    } else {
      await axios.get('http://localhost/api/articles.php/byCategory/' + this.filterProp)
        .then(response => (this.articles = response.data)
        )
        .catch(function (error) {
            console.log(error);
        });
    }
  },
  methods: {
    defineAmountValue () {
      return this.amountProp ? this.amountProp : this.articles.length; //If amountProp is empty show all articles by default 
    }
  }
}
</script>

<style scoped>
  #ctn_articlesPreview {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-evenly;
    border-bottom: var(--borderStyleStroke);
    border-top: var(--borderStyleStroke);
  }
  .article_Preview {
    width: 350px;
    margin-bottom: 10px;
    text-decoration: none;
    padding: 0px 10px;
  }
  .article_Preview img {
    width: 100%;
    height: 150px;
    object-fit: cover;
    filter: saturate(0);
  }
  .article_Preview div {
    padding: 20px;
    border-top: var(--borderStyleStroke);
  }
  .tags {
    color: var(--accentColor);
    font-family: WorkSans-Regular;
    font-size: 0.8em;
    margin: 0px 0px 5px 0px;
  }
  .title {
    color: var(--mainColor);
    font-family: InstrumentSerif-Regular;
    font-size: 1.3em;
    margin: 0%;
  }
</style>