<template>
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
                    <select name="imageArtist" v-model="article.imageArtist" required>
                        <option  v-for="(artist, index) in this.allArtists" :key="index" :value="artist.name">{{ artist.name }}</option>
                    </select>
                </div>
            </div>
            <div id="imageDescription">
                <label for="imageDescription">Descripción de la imagen</label>
                <textarea rows="5" maxlength="200" name="imageDescription" v-model="article.imageDescription" required></textarea>
                <p class="characterCount">{{ article.imageDescription.length }} / 200</p>
            </div>
        </div>
        <div class="form-group">
            <div>
                <div id="type">
                    <label for="type">Tipo</label>
                    <select name="type" v-model="article.type" required>
                        <option  v-for="(type, index) in this.allTypes" :key="index" :value="type.type">{{ type.type }}</option>
                    </select>
                </div>
                <div id="category">
                    <label for="category">Categoría</label>
                    <select name="category" v-model="article.category" required>
                        <option  v-for="(category, index) in this.allCategories" :key="index" :value="category.category">{{ category.category }}</option>
                    </select>
                </div>
                <div id="tags">
                    <label for="tags">Etiquetas</label>
                    <input type="text" name="tags" v-model="article.tags" required>
                </div>
            </div>
            <div id="summary">
                <label for="summary">Resumen del artículo</label>
                <textarea rows="8" name="summary" v-model="article.summary" required> </textarea>
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
                <button @click="publishArticle()">Publicar</button>
                <button class="cta" @click="createDraft()">Guardar borrador</button>
            </div>
        </div>
    </section>
    <Preview v-if="this.previewArticle" :article="this.article" @closePopUp="previewArticle = false" :key="article"></Preview>
</template>

<script>
import Preview from '@/components/Preview.vue';
import TextEditor from '@/components/TextEditor.vue';

export default {
    data() {
        return {
            previewArticle: false,
            allTypes: [],
            allCategories: [],
            allArtists: [],
            article:  {
                writer: '',
                title: '',
                coverImage: '',
                imageDescription: '',
                imageArtist: '',
                type: '',
                category: '',
                tags: '',
                summary: '',
                body: ''
            }
        }
    },
    components: {
        Preview,
        TextEditor
    },
    async created() {
        let apiBaseUrl = "http://localhost/api/public/";
        await axios.get(apiBaseUrl + 'articles.php/allCategories')
            .then(response => (this.allCategories = response.data)
            )
            .catch(function (error) {
                console.log(error);
            });
        await axios.get(apiBaseUrl + 'articles.php/allTypes')
            .then(response => (this.allTypes = response.data)
            )
            .catch(function (error) {
                console.log(error);
            });
        await axios.get(apiBaseUrl + 'general.php/allArtists')
            .then(response => (this.allArtists = response.data)
            )
            .catch(function (error) {
                console.log(error);
            });
    },
    methods: {
        uploadFile(event) {
            console.log(event.target.files[0]);
            this.coverImage = event.target.files[0];
        },
        displayPopUp(elementName) {
            if (elementName == 'submit') {
                let invalidFields = document.querySelectorAll('#writeArticleForm *:invalid');
                if (invalidFields.length) {
                    return;
                }
                else {
                    document.getElementById('savePopUp').style.display = 'block';
                    document.getElementById('savePopUp').style.opacity = 1;
                }
            } else if (elementName == 'preview') {
                this.previewArticle = true;
            }
        },
        createDraft() {
            console.log("Create draft!");
            let formData = new FormData();
            formData.append('author', this.article.writer);
            formData.append('title', this.article.title);
            formData.append('imageDescription', this.article.imageDescription);
            formData.append('imageArtist', this.article.imageArtist);
            formData.append('type', this.article.type);
            formData.append('category', this.article.category);
            formData.append('tags', this.article.tags);
            formData.append('summary', this.article.summary);
            formData.append('body', this.article.body);

            // var article = {};
            // formData.forEach(function(value, key){
            //     article[key] = value;
            // });

            axios({
                method: 'post',
                url: 'http://newsmagazine-api.000.pe/articles.php/createdraft',
                data: formData,
                config: { headers: {'Content-Type': 'multipart/form-data' }}
            })
            .then(function (response) {
                //handle success
                console.log(response)
                app.articles.push(article)
                app.resetForm();
            })
            .catch(function (response) {
                //handle error
                console.log(response)
            });
        },
        publishArticle() {
            console.log("Create article!");
            let formData = new FormData();
            formData.append('author', this.article.writer);
            formData.append('title', this.article.title);
            formData.append('imageDescription', this.article.imageDescription);
            formData.append('imageArtist', this.article.imageArtist);
            formData.append('type', this.article.type);
            formData.append('category', this.article.category);
            formData.append('tags', this.article.tags);
            formData.append('summary', this.article.summary);
            formData.append('body', this.article.body);

            // var article = {};
            // formData.forEach(function(value, key){
            //     article[key] = value;
            // });

            axios({
                method: 'post',
                url: 'http://newsmagazine-api.000.pe/articles.php/publishArticle',
                data: formData,
                config: { headers: {'Content-Type': 'multipart/form-data' }}
            })
            .then(function (response) {
                //handle success
                console.log(response)
                app.articles.push(article)
                app.resetForm();
            })
            .catch(function (response) {
                //handle error
                console.log(response)
            });
        },
        resetForm() {
            this.article =  {
                writer: '',
                title: '',
                coverImage: '',
                imageDescription: '',
                imageArtist: '',
                type: '',
                category: '',
                tags: '',
                summary: '',
                body: ''
            }
        }
    }

}
</script>