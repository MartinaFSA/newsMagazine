<template>
  <article>
    <p>titulo: {{this.article.title}}</p>
  </article>
</template>

<script>
export default {
  data() {
      return {
        articleId: null,
        article: ""
      }
  },
  mounted() {
    axios.get('http://localhost/api/articles.php/byId/' + this.articleId)
        .then(response => (this.article = response.data[0])
        )
        .catch(function (error) {
            console.log(error);
        });
  },
  created() {
    let articleId = window.location.pathname.split("/").pop();
    this.articleId = articleId;
  }
}
</script>

<style>

</style>