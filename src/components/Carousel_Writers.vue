<template>
  
    <div class="ctn_carousel"> <!--Carousel-->
        <div class="inner ctn_writers" ref="inner" :style="innerStyles"><!--inner-->
            <div v-for="(writer, index) in this.allWriters" :key="index" class="writerProfileCard" @mouseover="showBio(index)" @mouseleave="hideBio(index)"> <!--card-->
                <div class="writerProfiles">
                    <div>
                        <img :src="'../src/assets/images/writer/' + writer.id + '.jpg'" :alt="'Foto de ' + writer.name">
                        <p>{{writer.profession}}</p>
                        <p class="smallGrayText">{{writer.location}}</p>
                    </div>
                </div>
                <div class="writerName mediumBlueText">
                    <p>{{ writer.name }}</p>
                </div>
                <div class="writerBio" :id="'writerBio_' + index">
                    <p>{{ writer.bio }}</p>
                    <RouterLink :to="'/collaborator/' + writer.id" alt="Ir al perfil del cronista">Leer más</RouterLink>
                </div>
            </div>
        </div>
    </div>
    <div class="carrousel_controls">
        <button @click="prev"><img src="@/assets/arrow-icon-left.svg" alt="Next article" srcset=""></button>
        <p>Deslizar</p>
        <button @click="next"><img src="@/assets/arrow-icon-right.svg" alt="Next article" srcset=""></button>
    </div>
</template>

<script>
export default {
    data() {
        return {
            allWriters: [],
            innerStyles: {},
            step: '',
            transitioning: false
        }
    },
    async created() {
        await axios.get('http://localhost/api/general.php/allWriters')
            .then(response => (this.allWriters = response.data))
            .catch(function (error) {
                console.log(error);
            });
        
        getSocials(this.allWriters);

        function getSocials(jsonData) {
            jsonData.forEach(person => {
                let cleanLinks = person.socialMedia.split('"');
                cleanLinks = cleanLinks.filter(name => name.includes('www.'))
                person.socialMedia = cleanLinks;
            });
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
            const innerWidth = this.$refs.inner.scrollWidth
            const totalCards = this.allWriters.length
            this.step = `${innerWidth / totalCards}px`
        },
        next () {
            if (this.transitioning) return;
            this.transitioning = true;
            this.moveLeft();
            this.afterTransition(() => {
                const writer = this.allWriters.shift();
                this.allWriters.push(writer);
                this.resetTranslate();
                this.transitioning = false;
            })
        },
        prev () {
            if (this.transitioning) return;
            this.transitioning = true;
            this.moveRight();
            this.afterTransition(() => {
                const writer = this.allWriters.pop();
                this.allWriters.unshift(writer);
                this.resetTranslate();
                this.transitioning = false;
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
                this.$refs.inner.removeEventListener('transitionend', listener)
            }
            this.$refs.inner.addEventListener('transitionend', listener)
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
    .ctn_carousel {
        width: 100%;
        overflow: hidden;
    } .inner {
        transition: transform 0.1s; /*how much time should it pass before showing next article*/
        white-space: nowrap;
    }
    /*WRITERS*/
    .ctn_writers {
        display: flex;
        flex-direction: row;
        align-items: flex-start;
        margin: 0px;
        border-left: var(--borderStyleStroke);
        border-top: var(--borderStyleStroke);
    } .writerProfileCard {
        display: flex;
        flex-direction: column;
        justify-content: center;
        border-left: var(--borderStyleStroke);
    } .writerProfileCard:last-of-type {
        border-right: var(--borderStyleStroke);
    } .writerProfiles, .writerName {
        text-wrap: nowrap;
        text-align: center;
        padding: 20px var(--contentPadding);
    } .writerProfiles div > p:first-of-type{
        padding: 0px;
        margin: 10px 0px 0px;
        font-weight: 500;
        font-family: WorkSans-Regular;
        color: var(--mainColor);
    } .writerProfiles div > p:last-of-type{
        padding: 0px;
        margin: 0px 0px 20px;
    } .writerProfiles img {
        height: 337px;
        object-fit: cover;
        filter: saturate(0);
        transition: filter 0.5s ease-in-out;
    } .writerProfileCard:hover img {
        filter: saturate(1);
    }
    .writerName  {
        border-top: var(--borderStyleStroke);
        border-bottom: var(--borderStyleStroke);
    } .writerName p {
        padding: 0%;
        margin: 0%;
    } .writerBio {
        text-wrap: wrap;
        background-color: var(--accentColor);
        padding: 0px var(--contentPadding);
        color: var(--bodyBackground);
    } .writerBio a {
        color: var(--bodyBackground);
    }

@media (pointer:fine) {
    .writerBio {
        overflow: hidden;
        height: 0;
        transition: all .6s ease-in-out;
    } .writerBio p {
        display: -webkit-box; 
        -webkit-box-orient: vertical; 
        -webkit-line-clamp: 7; 
        overflow: hidden; 
        text-overflow: ellipsis; 
    } .slideDown {
        height: 200px;
    }
}
@media not (pointer:fine) {
    .writerBio {
        padding: 20px var(--contentPadding);
        height: 200px;
    } .writerBio p {
        display: -webkit-box; 
        -webkit-box-orient: vertical; 
        -webkit-line-clamp: 8; 
        overflow: hidden; 
        text-overflow: ellipsis; 
    }
}

@media screen and (max-width: 360px) {  
    .writerProfileCard {
        width: 90vw;
    }
    .writerProfiles img {
        width: 90vw;
        max-width: 310px;
    }
}
@media screen and (min-width: 361px) {
    .writerProfileCard {
        width: 350px;
    } 
    .writerProfiles img {
        width: 310px;
    }
}

@media screen and (max-width: 800px) {
    .ctn_writers {
        padding-left: var(--contentPadding);
    }
}
@media screen and (min-width: 801px) {
    .ctn_writers {
        padding-left: var(--pagePadding);
    }
}
</style>