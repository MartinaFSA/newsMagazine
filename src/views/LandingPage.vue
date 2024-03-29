<template>
  <main>
    <section id="welcome">
        <div>
            <p>NEWS</p>
            <p>laboratorio de no ficción creativa</p>
        </div>
    </section>
    <section>
        <div class="ctn_subtitle">
            <div>// Destacados</div>
            <div>Escritos por el equipo de colaboradores</div>
        </div>
        <div id="ctn_outstandingArticle">
            <div v-for="(article, index) in this.outstandingArticles" :key="index" class="outstanding_article">
                <p class="tags">{{article.tags}}</p>
                <p class="title">{{article.title}}</p>
                <p class="authors">Por <span>{{article.authors}}</span></p>
                <div class="ctn_description"><p class="description">{{ article.summary}}</p></div>
                <div class="dateAndPlus flexBetween">
                    <p>{{article.date}}</p>
                    <RouterLink :to="'/article/' + article.id" alt="Ir al artículo" class="plusButton"><img src="@/assets/plus-icon.svg"></RouterLink>
                </div>
            </div>
        </div>
    </section>
    <section>
        <div class="ctn_subtitle">
            <div>// Recientes</div>
        </div>
        <div class="ctn_recent">
            <div class="categories_name">
                <div v-for="(category, index) in this.allCategories" :key="index"><p>{{ category.category }}</p></div>
            </div>
            <!--Generate a row for each category and add 5 articles in them-->
            <div class="ctn_categories carousel">
                <div class="inner" ref="inner" :style="innerStyles" v-for="(categoryRow, index) in recentFiveCategorized.length"  :key="index">
                    <div v-for="(card) in recentFiveCategorized[index]" :key="card.id" class="category card">
                        <div class="categoryMobile"><p>{{card.category}}</p></div>
                        <p>{{ card.title }}</p>
                        <p>Por <span>{{card.authors}}</span> // Arte <span>{{ card.artist }}</span></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="carrousel_controls">
            <button @click="prev"><img src="@/assets/arrow-icon-left.svg" alt="Next article" srcset=""></button>
            <RouterLink to="/allArticles">Ver más</RouterLink>
            <button @click="next"><img src="@/assets/arrow-icon-right.svg" alt="Next article" srcset=""></button>
        </div>
    </section>
    <section>
        <div class="ctn_subtitleSecondType">
            <div>
                <p> // Cronistas</p>
            </div>
        </div>
        <div class="ctn_writers">
            <div v-for="(writer, index) in this.allWriters" :key="index" class="writerProfileImg" @mouseover="showBio(index)" @mouseleave="hideBio(index)">
                <div class="writerProfiles">
                    <div>
                        <img :src="'../assets/images/writer/' + writer.id + '.jpg'" :alt="'Foto de ' + writer.name">
                        <p>{{writer.profession}}</p>
                        <p>{{writer.location}}</p>
                    </div>
                </div>
                <div class="writerInfo">
                    <div class="writerName">
                        <p>{{ writer.name }}</p>
                    </div>
                </div>
                <div class="writerBio" :id="'writerBio_' + index">
                    <p>{{ writer.bio }}</p>
                    <div>
                        <div v-for="(socialLink, index) in writer.socialMedia" :key="index">
                            <p>{{ socialLink }}</p>
                        </div>
                        <div>LEER MÁS</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section>
        <div class="ctn_subtitleSecondType">
            <div>
                <p> // Artistas</p>
            </div>
        </div>
        <div class="ctn_artistas">
            <div v-for="(artist, index) in this.allArtists" :key="index">
                <a>{{ artist.name }} / </a>
                <img src="" alt="">
            </div>
            <div>
                <p>artist.name</p>
                <p>artist.location</p>
                <p>artist.bio</p>
                <p>Artículos ilustrados</p>
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
            outstandingArticles: [],
            recentFiveCategorized: [],
            allCategories: [],
            allWriters: [],
            allArtists: [],
            innerStyles: {},
            step: '',
            transitioning: false
        }
    },
    async created() {
        await axios.get('http://localhost/api/outstandingArticles.php/all')
            .then(response => (this.outstandingArticles = response.data)
            )
            .catch(function (error) {
                console.log(error);
            });
        await axios.get('http://localhost/api/articles.php/recentFiveCategorized')
            .then(response => divideCategoriesInRows(response.data))
            .then(response => this.recentFiveCategorized = response)
            .catch(function (error) {
                console.log(error);
            });
        await axios.get('http://localhost/api/articles.php/allCategories')
            .then(response => (this.allCategories = response.data)
            )
            .catch(function (error) {
                console.log(error);
            });
        await axios.get('http://localhost/api/general.php/allWriters')
            .then(response => (this.allWriters = response.data))
            .catch(function (error) {
                console.log(error);
            });
        await axios.get('http://localhost/api/general.php/allArtists')
            .then(response => (this.allArtists = response.data))
            .catch(function (error) {
                console.log(error);
            });
        
        
        getSocials(this.allArtists);
        getSocials(this.allWriters);

        function getSocials(jsonData) {
            jsonData.forEach(person => {
                let cleanLinks = person.socialMedia.split('"');
                cleanLinks = cleanLinks.filter(name => name.includes('www.'))
                person.socialMedia = cleanLinks;
            });
        }

        function divideCategoriesInRows(data) {
            let array = [];
            for (let i = 0; i < data.length; i += 5) {
                const chunk = data.slice(i, i + 5);
                array.push(chunk);
            }
            return array;
        }

        this.setStep();
        this.resetTranslate();
    },
    methods: {
        showBio(index) {
            let bio = document.getElementById('writerBio_' + index);
            bio.classList.add('slideDown');
        },
        hideBio(index) {
            let bio = document.getElementById('writerBio_' + index);
            bio.classList.remove('slideDown');
        },

        setStep () {
            const innerWidth = this.$refs.inner[0].scrollWidth
            const totalCards = this.recentFiveCategorized.length
            this.step = `${innerWidth / totalCards}px`
        },
        next () {
            if (this.transitioning) return;
            this.transitioning = true;
            this.moveLeft();
            this.afterTransition(() => {
                for (let i = 0; i < this.recentFiveCategorized.length; i++) {
                    const article = this.recentFiveCategorized[i].shift()
                    this.recentFiveCategorized[i].push(article);
                    this.resetTranslate();
                    this.transitioning = false;
                }
            })
        },
        prev () {
            if (this.transitioning) return;
            this.transitioning = true;
            this.moveRight();
            this.afterTransition(() => {
                for (let i = 0; i < this.recentFiveCategorized.length; i++) {
                    const article = this.recentFiveCategorized[i].pop()
                    this.recentFiveCategorized[i].unshift(article)
                    this.resetTranslate()
                    this.transitioning = false
                }
            })

        },
        moveLeft () {
            this.innerStyles = {
            //add a - to the first translate for a scroll effect 
            transform: `translateX(${this.step})
                        translateX(-${this.step})`
            }
        },
        moveRight () {
            this.innerStyles = {
            transform: `translateX(${this.step})
                        translateX(-${this.step})`
            }
        },
        afterTransition (callback) {
            const listener = () => {
                callback()
                for (let i = 0; i < this.recentFiveCategorized.length; i++) {
                    this.$refs.inner[i].removeEventListener('transitionend', listener)
                }
            }
            for (let i = 0; i < this.recentFiveCategorized.length; i++) {
                this.$refs.inner[i].addEventListener('transitionend', listener)
            }
        },
        resetTranslate () {
            this.innerStyles = {
            transition: 'none',
            }
        }
    }
}
</script>

<style scoped>
@import '@/assets/styles/landingPage.css';

</style>