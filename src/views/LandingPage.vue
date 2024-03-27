<template>
  <main>
    <section>
        <div class="ctn_subtitle">
            <div>// Destacados</div>
            <div>Escritos por el equipo de colaboradores</div>
        </div>
        <div id="ctn_outstandingArticle">
            <div v-for="(article, index) in this.outstandingArticles" :key="index" class="outstanding_article">
                <div><p>{{article.tags}}</p></div>
                <p>{{article.title}}</p>
                <div><p>Por <span>{{article.authors}}</span></p></div>
                <p class="description">{{ article.summary}}</p>
                <div class="dateAndPlus flexBetween">
                    <p>{{article.date}}</p>
                    <RouterLink :to="'/article/' + article.id" alt="Ir al artículo" class="plusButton">+</RouterLink>
                </div>
            </div>
        </div>
    </section>
    <section>
        <div class="ctn_subtitle">
            <div>// Categorías</div>
        </div>
        <div>
            <div class="emptyBoxes"></div>
            <div>
                <div v-for="(category, index) in this.categories" :key="index" class="category_row">
                    <div class="category"><p>{{category}}</p></div>
                    <div v-for="(article, index) in this.selectedArticles" :key="index">
                        <p>{{ article }}</p>
                        <p>Por <span v-for="(author, index) in article.authors" :key="index">{{author}}, </span></p>
                    </div>
                </div>
            </div>
        </div>
    </section>
  </main>
</template>

<script>
import axios from 'axios';

export default {
    data() {
        return {
            articles: [],
            outstandingArticles: [],
            categories: [],
            selectedArticles: null
        }
    },
    mounted() {
        axios.get('http://localhost/api/outstandingArticles.php')
            .then(response => (this.outstandingArticles = response.data)
            )
            .catch(function (error) {
                console.log(error);
            });
    },
    created() {
        this.articles;
        this.categories = "" //"SELECT category from articles_active GROUP BY category"
        this.selectedArticles = "" //"SELECT title, author, route, category from articles_active LIMIT 5 ORDER BY ID DESC";
    }
}
</script>

<style scoped>
@import '@/assets/styles/landingPage.css';

</style>