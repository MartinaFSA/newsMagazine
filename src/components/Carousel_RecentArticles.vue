<template>
    <div class="ctn_recent">
        <div class="categories_name">
            <div v-for="(category, index) in this.allCategories" :key="index"><p>{{ category.category }}</p></div>
        </div>
        <!--Generate a row for each category and add 5 articles in them-->
        <div class="ctn_categories carousel">
            <div class="inner" ref="inner" :style="innerStyles" v-for="(categoryRow, index) in recentFiveCategorized.length"  :key="index">
                <RouterLink :to="'/article/' + card.id" alt="Ir al artículo" v-for="(card) in recentFiveCategorized[index]" :key="card.id" class="category card">
                    <div class="categoryMobile"><p>{{card.category}}</p></div>
                    <p>{{ card.title }}</p>
                    <p>Por <span>{{card.authors}}</span> // Arte <span>{{ card.artist }}</span></p>
                </RouterLink>
            </div>
        </div>
    </div>
    <div class="carrousel_controls">
        <button @click="prev"><img src="@/assets/arrow-icon-left.svg" alt="Next article" srcset=""></button>
        <RouterLink to="/allArticles">Ver más</RouterLink>
        <button @click="next"><img src="@/assets/arrow-icon-right.svg" alt="Next article" srcset=""></button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            recentFiveCategorized: [],
            allCategories: [],
            innerStyles: {},
            step: '',
            transitioning: false
        }
    },
    async created() {
        let apiBaseUrl = "https://api-newsmagazine.000webhostapp.com/api/public/";
        await axios.get(apiBaseUrl + 'articles.php/recentFiveCategorized')
            .then(response => divideCategoriesInRows(response.data))
            .then(response => this.recentFiveCategorized = response)
            .catch(function (error) {
                console.log(error);
            });
        await axios.get(apiBaseUrl + 'articles.php/allCategories')
            .then(response => (this.allCategories = response.data)
            )
            .catch(function (error) {
                console.log(error);
            });

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
/*CAROUSEL*/
.carousel {
    width: 100%;
    overflow: hidden;
} .inner {
    transition: transform 0.1s; /*how much time should it pass before showing next article*/
    white-space: nowrap;
    display: flex;
    flex-direction: row;
} .card {
    width: 600px;
    display: inline-flex;
    border-right: var(--borderStyleStroke);
} .inner:not(:last-of-type) {
    border-bottom: var(--borderStyleStroke);
} .category {
    text-decoration: none;
}
.categories_name > div, .category {
    padding: 10px var(--contentPadding);
}

/*RECENT*/
.ctn_recent {
    display: flex;
    outline: var(--borderStyleStroke);
} .categories_name > div {
    font-family: WorkSans-Italic;
    text-transform: uppercase;
} .categories_name p {
    margin: 0%;
}
.ctn_categories {
    outline: var(--borderStyleStroke);
} .category {
    flex-direction: column;
    justify-content: center;
    background-color: var(--bodyBackground);
} .category p {
    color: var(--mainColor);
} .category > p:first-of-type {
    font-family: InstrumentSerif-Regular;
    font-size: 1.5em;
    margin: 0%;
} .category > p:not(:first-of-type) {
    font-family: WorkSans-Italic;
    margin: 0%;
} .category span {
    font-weight: 500;
} .categories_name > div, .category {
    height: 85px;
} 


@media screen and (max-width: 800px) {
    .category {
        position: relative;
    }
    .categories_name {
        display: none;
    } .categoryMobile {
        position: absolute;
        top: 0px;
        left: 0px;
        background-color: var(--secondaryColor);
    } .categoryMobile p {
        padding:  2px var(--contentPadding);
        margin: 0%;
        color: var(--bodyBackground);
        font-family: WorkSans-Italic;
    }
}
@media screen and (min-width: 801px) {
    /*RECENT*/
    .ctn_recent {
        padding-left: var(--pagePadding);
    } 
    .categories_name {
        width: 600px;
        border-left: var(--borderStyleStroke);
    } .categories_name > div {
        display: flex;
        align-items: center;
        border-right: var(--borderStyleStroke);
    } .categories_name > div:not(:last-of-type) {
        border-bottom: var(--borderStyleStroke);
    } .categoryMobile {
        display: none;
    }
}
</style>