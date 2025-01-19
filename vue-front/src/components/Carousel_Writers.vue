<template>
    <section>
        <div class="ctn_carousel"> <!-- Carousel -->
            <div class="inner ctn_writers" ref="inner" :style="innerStyles"><!-- inner -->
                <div v-for="(writer, index) in allWriters" :key="index" class="writerProfileCard" 
                     @mouseover="toggleBio(index)" @mouseleave="toggleBio(index)"> <!-- card -->
                    <div class="writerProfiles">
                        <div>
                            <img :src="'../src/assets/images/profile/' + writer.id + '.jpg'" :alt="'Foto de ' + writer.name">
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
            <button @click="prev"><img src="@/assets/arrow-icon-left.svg" alt="Previous article" /></button>
            <p>Deslizar</p>
            <button @click="next"><img src="@/assets/arrow-icon-right.svg" alt="Next article" /></button>
        </div>
    </section>
</template>

<script setup lang="ts">
import { ref, onBeforeMount, nextTick } from 'vue';
import axios from 'axios';
import type { IWriter } from '@/data/models';
import { dbUrl } from '@/assets/common';

const apiBaseUrl = dbUrl();

const allWriters = ref<IWriter[]>([]);
const innerStyles = ref<{ [key: string]: string }>({});
const step = ref(0);  // Fixed typing for step to be number
const transitioning = ref(false);

// Refs for accessing DOM elements
const inner = ref<HTMLElement | null>(null);

// Fetch writers when component mounts
onBeforeMount(async () => {
    try {
        const response = await axios.get(`${apiBaseUrl}allWriters`);
        allWriters.value = response.data;
    } catch (error) {
        console.error(error);
    }
    await nextTick();  // Make sure DOM is updated before setting the step
    setStep();
    resetTranslate();
});

// Show and hide bio functions
function toggleBio(index: number): void {
    const bio = document.getElementById(`writerBio_${index}`);
    bio?.classList.toggle('slideDown');
}

// Set the step for carousel translation
function setStep(): void {
    if (inner.value) {
        const innerWidth = inner.value.scrollWidth;
        const totalCards = allWriters.value.length;
        step.value = innerWidth / totalCards;
    }
}

// Handle next slide action
function next(): void {
    if (transitioning.value) return;
    transitioning.value = true;
    moveLeft();
    afterTransition(() => {
        const writer = allWriters.value.shift();
        if (writer) {
            allWriters.value.push(writer);
        }
        resetTranslate();
        transitioning.value = false;
    });
}

// Handle previous slide action
function prev(): void {
    if (transitioning.value) return;
    transitioning.value = true;
    moveRight();
    afterTransition(() => {
        const writer = allWriters.value.pop();
        if (writer) {
            allWriters.value.unshift(writer);
        }
        resetTranslate();
        transitioning.value = false;
    });
}

// Move the carousel to the left
function moveLeft(): void {
    innerStyles.value = {
        transform: `translateX(-${step.value}px)`
    };
}

// Move the carousel to the right
function moveRight(): void {
    innerStyles.value = {
        transform: `translateX(${step.value}px)`
    };
}

// Callback after transition ends
function afterTransition(callback: () => void): void {
    const listener = () => {
        callback();
        if (inner.value) {
            inner.value.removeEventListener('transitionend', listener);
        }
    };
    if (inner.value) {
        inner.value.addEventListener('transitionend', listener);
    }
}

// Reset translation styles
function resetTranslate(): void {
    innerStyles.value = {
        transition: 'none'
    };
}
</script>

<style scoped>
.ctn_carousel {
    width: 100%;
    overflow: hidden;
}

.inner {
    transition: transform 0.1s; /* How much time should it pass before showing the next article */
    white-space: nowrap;
}

/* WRITERS */
.ctn_writers {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    margin: 0px;
    border-left: var(--borderStyleStroke);
    border-top: var(--borderStyleStroke);
}

.writerProfileCard {
    display: flex;
    flex-direction: column;
    justify-content: center;
    border-left: var(--borderStyleStroke);
}

.writerProfileCard:last-of-type {
    border-right: var(--borderStyleStroke);
}

.writerProfiles, .writerName {
    white-space: nowrap;
    text-align: center;
    padding: 20px var(--contentPadding);
}

.writerProfiles div > p:first-of-type {
    padding: 0px;
    margin: 10px 0px 0px;
    font-weight: 500;
    font-family: WorkSans-Regular;
    color: var(--mainColor);
}

.writerProfiles div > p:last-of-type {
    padding: 0px;
    margin: 0px 0px 20px;
}

.writerProfiles img {
    height: 337px;
    object-fit: cover;
    filter: saturate(0);
    transition: filter 0.5s ease-in-out;
}

.writerProfileCard:hover img {
    filter: saturate(1);
}

.writerName {
    border-top: var(--borderStyleStroke);
    border-bottom: var(--borderStyleStroke);
}

.writerName p {
    padding: 0%;
    margin: 0%;
}

.writerBio {
    white-space: wrap;
    background-color: var(--accentColor);
    padding: 0px var(--contentPadding);
    color: var(--bodyBackground);
}

.writerBio a {
    color: var(--bodyBackground);
}

@media (pointer: fine) {
    .writerBio {
        overflow: hidden;
        height: 0;
        transition: all .6s ease-in-out;
    }

    .writerBio p {
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 7;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .slideDown {
        height: 200px;
    }
}

@media not (pointer: fine) {
    .writerBio {
        padding: 20px var(--contentPadding);
        height: 200px;
    }

    .writerBio p {
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