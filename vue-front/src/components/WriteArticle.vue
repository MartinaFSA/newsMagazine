<template>
    <section>
        <form id="writeArticleForm" @submit.prevent>
            <div id="title">
                <label for="title">Título</label>
                <input maxlength="200" type="text" name="title" v-model="article.title" required>
                <p class="characterCount">{{ article.title.length }} / 200</p>
            </div>
            <div class="form-group">
                <div>
                    <div id="coverImage">
                        <label for="coverImage">Imagen de portada</label>
                        <input type="file" name="coverImage" accept="image/png, image/jpeg" @change="uploadFile" required>
                    </div>
                    <div id="imageArtist">
                        <label for="imageArtist">Artista</label>
                        <select name="imageArtist" v-model="article.artist" required>
                            <option v-for="(artist, index) in allArtists" :key="index" :value="artist.name">{{ artist.name }}</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div>
                    <div id="type">
                        <label for="type">Tipo</label>
                        <select name="type" v-model="article.type" required>
                            <option v-for="(type, index) in allTypes" :key="index" :value="type.type">{{ type.type }}</option>
                        </select>
                    </div>
                    <div id="category">
                        <label for="category">Categoría</label>
                        <select name="category" v-model="article.category" required>
                            <option v-for="(category, index) in allCategories" :key="index" :value="category.category">{{ category.category }}</option>
                        </select>
                    </div>
                    <div id="tags">
                        <label for="tags">Etiquetas</label>
                        <input type="text" name="tags" v-model="article.tags" required>
                    </div>
                </div>
                <div id="summary">
                    <label for="summary">Resumen del artículo</label>
                    <textarea rows="8" name="summary" v-model="article.summary" required></textarea>
                </div>
            </div>
            <TextEditor></TextEditor>

            <button @click="displayPopUp('preview')">Preview</button>
            <input class="cta" type="submit" value="Subir" @click="displayPopUp('submit')">
        </form>

        <section id="savePopUp" class="overlay">
            <div class="overlay_content">
                <p>Asegurate de que la información sea correcta, una vez publicado no podrás editar el artículo.</p>
                <p class="question">¿Queres publicar tu artículo ahora?</p>
                <div class="actions">
                    <button @click="publishArticle">Publicar</button>
                    <button class="cta" @click="createDraft">Guardar borrador</button>
                </div>
            </div>
        </section>
        <Preview v-if="previewArticle" :article="article" @closePopUp="previewArticle = false" :key="article"></Preview>
    </section>
</template>

<script setup lang="ts">
    import { onBeforeMount, ref } from 'vue';
    import { dbUrl } from '@/assets/common';
    import axios from 'axios';
    import type { IArtist, IArticle } from '@/data/models';
    import Preview from '@/components/Preview.vue';
    import TextEditor from '@/components/TextEditor.vue';

    const apiBaseUrl = dbUrl();

    const allArtists = ref<IArtist[]>([]);
    const article = ref<IArticle>();
    const previewArticle = ref(false);
    const allTypes = ref([]);
    const allCategories = ref([]);

    onBeforeMount(async () => {
        try {
            const [categoriesResponse, typesResponse, artistsResponse] = await Promise.all([
                axios.get(`${apiBaseUrl}allCategories`),
                axios.get(`${apiBaseUrl}allTypes`),
                axios.get(`${apiBaseUrl}allArtists`)
            ]);
            allCategories.value = categoriesResponse.data;
            allTypes.value = typesResponse.data;
            allArtists.value = artistsResponse.data;
        } catch (error) {
            console.error(error);
        }
    });

    function uploadFile(event: Event) {
        const input = event.target as HTMLInputElement;
        if (input.files && input.files[0]) {
            const coverImg = input.files[0];
            console.log(coverImg); // Handle the image file as needed
        }
    }

    function displayPopUp(elementName: string) {
        const savePopUp = document.getElementById('savePopUp') as HTMLElement;

        if (elementName === 'submit') {
            const invalidFields = document.querySelectorAll('#writeArticleForm *:invalid');
            if (invalidFields.length) {
                return;
            } else {
                savePopUp.style.display = 'block';
                savePopUp.style.opacity = '1';
            }
        } else if (elementName === 'preview') {
            previewArticle.value = true;
        }
    }

    async function createDraft() {
        console.log('Create draft!');
        const formData = new FormData();
        formData.append('author', article.value.writer);
        formData.append('title', article.value.title);
        formData.append('artist', article.value.artist);
        formData.append('type', article.value.type);
        formData.append('category', article.value.category);
        formData.append('tags', article.value.tags);
        formData.append('summary', article.value.summary);
        formData.append('body', article.value.body);

        try {
            const response = await axios.post(`${apiBaseUrl}createdraft`, formData, {
                headers: { 'Content-Type': 'multipart/form-data' }
            });
            console.log(response);
            // Assuming app.articles and app.resetForm() are accessible from this context.
            // app.articles.push(article.value);
            // app.resetForm();
        } catch (error) {
            console.error(error);
        }
    }

    async function publishArticle() {
        console.log('Publish article!');
        const formData = new FormData();
        formData.append('author', article.value.writer);
        formData.append('title', article.value.title);
        formData.append('artist', article.value.artist);
        formData.append('type', article.value.type);
        formData.append('category', article.value.category);
        formData.append('tags', article.value.tags);
        formData.append('summary', article.value.summary);
        formData.append('body', article.value.body);

        try {
            const response = await axios.post(`${apiBaseUrl}publishArticle`, formData, {
                headers: { 'Content-Type': 'multipart/form-data' }
            });
            console.log(response);
            // Handle the response (e.g., redirect or clear the form)
        } catch (error) {
            console.error(error);
        }
    }

    function resetForm() {
        article.value['title'] = ''
        article.value['artist'] = ''
        article.value['type'] = ''
        article.value['category'] = ''
        article.value['tags'] = ''
        article.value['summary'] = ''
        article.value['body'] = ''
        article.value['writer'] = ''
    }
</script>