<template>
    <form>
        <div id="title">
            <label for="title">Título</label>
            <input type="text" name="title" v-model="title" required>
        </div>
        <div id="type">
            <label for="type">Tipo</label>
            <select name="type" v-model="type" required>
                <option  v-for="(category, index) in this.allCategories" :key="index" :value="category.category">{{ category.category }}</option>
            </select>
        </div>
        <div id="category">
            <label for="category">Categoría</label>
            <input type="text" name="category" v-model="category" required>
        </div>
        <div id="tags">
            <label for="tags">Etiquetas</label>
            <input type="text" name="tags" v-model="tags" required>
        </div>
        <div id="summary">
            <label for="summary">Resumen</label>
            <input type="text" name="summary" v-model="summary" required>
        </div>
        <div id="body">
            <label for="body">Cuerpo</label>
            <input type="text" name="body" v-model="body" required>
        </div>

        <input type="button" @click="createArticle()" value="Subir">
    </form>
</template>

<script>
export default {
    data() {
        return {
            title: '',
            type: '',
            category: '',
            tags: '',
            summary: '',
            body: ''
        }
    },
    methods: {
        createArticle() {
            console.log("Create article!");
            let formData = new FormData();
            formData.append('title', this.title);
            formData.append('type', this.type);
            formData.append('category', this.category);
            formData.append('tags', this.tags);
            formData.append('summary', this.summary);
            formData.append('body', this.body);

            var article = {};
            formData.forEach(function(value, key){
                article[key] = value;
            });

            axios({
                method: 'post',
                url: 'http://newsmagazine-api.000.pe/articles.php',
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
            this.title = '';
            this.type = '';
            this.category = '';
            this.tags = '';
            this.summary = '';
            this.body = ''
        }
    }

}
</script>

<style scoped>
form {
    padding: 20px var(--pagePadding);
}
form > div {
    margin-bottom: 20px;
}
label {
    display: block;
    margin-bottom: 5px;
}
label, input, select {
    font-size: 1.1em;
    font-family: WorkSans-Regular;
    font-weight: 400;
    color: var(--mainColor);
}
input, select {
    background-color: var(--bodyBackground);
    border: var(--borderStyleStroke);
    padding: 5px 10px;
}
input[type=button] {
    color: var(--bodyBackground);
    background-color: var(--accentColor);
    padding: 2.5px var(--pagePadding);
}

#title input, #body input {
    width: 100%;
}
#type, #category, #tags, #summary {
    width: 50%;
    display: inline-block;
}

</style>