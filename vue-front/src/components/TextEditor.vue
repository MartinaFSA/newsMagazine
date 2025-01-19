<template>
  <div id="body">
    <label for="body">Cuerpo</label>
    <div class="ctn_formatBtns">
      <!-- Text Format -->
      <button type="button" @click="modifyText('strong', null)" class="format"><img src="@/assets/icons/bold.svg" alt="bold"></button>
      <button type="button" @click="modifyText('i', null)" class="format"><img src="@/assets/icons/italic.svg" alt="italic"></button>
      <button type="button" @click="modifyText('u', null)" class="format"><img src="@/assets/icons/underline.svg" alt="underline"></button>
      <button type="button" @click="modifyText('s', null)" class="format"><img src="@/assets/icons/strikethrough.svg" alt="strikethrough"></button>

      <!-- Link -->
      <button ref="createLink" type="button" @click="addLink()"><img src="@/assets/icons/link.svg" alt="Add Link"></button>
      <button type="button" @click="modifyText('removeLink', 'removeLink')"><img src="@/assets/icons/unlink.png" alt="Remove Link"></button>

      <!-- Alignment -->
      <button type="button" @click="modifyText('textAlign', 'left')" class="align"><img src="@/assets/icons/align-left.svg" alt="Align Left"></button>
      <button type="button" @click="modifyText('textAlign', 'center')" class="align"><img src="@/assets/icons/align-center.svg" alt="Align Center"></button>
      <button type="button" @click="modifyText('textAlign', 'right')" class="align"><img src="@/assets/icons/align-right.svg" alt="Align Right"></button>
      
      <!-- Headings -->
      <select @change="modifyText('preset', $event.target.value)">
        <option v-for="(preset, index) in presetStyles" :value="preset" :key="index">{{preset.opt}}</option>
      </select>

      <!-- Font -->
      <select @change="modifyText('fontSize', $event.target.value)">
        <option v-for="(fontSizeOpt, index) in fontSizeOpts" :value="fontSizeOpt.size" :key="index">{{fontSizeOpt.opt}}</option>
      </select>
      <select @change="modifyText('fontFamily', $event.target.value)">
        <option v-for="(fontName, index) in fontList" :value="fontName + '-Regular'" :key="index">{{ fontName }}</option>
      </select>
      
      <button type="button" @click="eraseAll" class="align">Borrar formato</button>
      
      <!-- Undo/Redo -->
      <button type="button" id="undo" class="option-button"> undo </button>
      <button type="button" id="redo" class="option-button"> redo </button>

      <!-- Color -->
      <div class="input-wrapper">
        <input type="color" name="fontColor" @change="modifyText('color', $event.target.value)"/>
        <label for="fontColor">Font Color</label>
      </div>
      <div class="input-wrapper">
        <input type="color" id="bkgColor"  @change="modifyText('backgroundColor', $event.target.value)"/>
        <label for="bkgColor">Highlight Color</label>
      </div>
    </div>
    
    <div ref="writingArea" id="text-input" contenteditable="true" @paste="pasteContent($event)"></div>
    
    <!-- <textarea ref="writingArea" id="text-input" contenteditable="true" rows="20" name="body" v-model="body" required></textarea> -->
  </div>
</template>

<script setup lang="ts">
    import { onBeforeMount, ref } from "vue"

    const fontList = ref(["WorkSans", "InstrumentSerif"])
    const fontSizeOpts = ref([{"opt": "Small", "size": "1em"}, {"opt": "Medium", "size": "1.3em"}, {"opt": "Large", "size": "1.7em"}])
    const presetStyles = ref([{"opt": "H2", "tag": "h2"}, {"opt": "H3", "tag": "h3"}, {"opt": "Frase", "tag": "blockquote"}, {"opt": "Pie", "tag": "figcaption"}])
    
    onBeforeMount(() => {
        initializer();
    })
    
    //Initial Settings
    function initializer() {
    }

    function pasteContent(e) {
        e.preventDefault();
        const text = e.clipboardData.getData('text/plain');
        const textNode = document.createTextNode(text);
        $refs.writingArea.appendChild(textNode);
    }

    function modifyText(command, value) {
        //command -> tag name to add or style type
        //value -> if it's null just add the node, else append the value to the style
        let selectedTextRange = window.getSelection().getRangeAt(0);
        let parentSelection = selectedTextRange.commonAncestorContainer;

        if (value === null ) {
            let node = document.createElement(command);

            //is selection already wrapped in style tag?
            let nodeIndex = -1;
            if (parentSelection.hasChildNodes()) {
                for(let i = 0; i < parentSelection.children.length; i++) {
                    if (parentSelection.children[i].tagName === node.tagName) {
                        nodeIndex = i;
                    };
                };
            }
            if (nodeIndex >= 0) {
                //remove surrounding tag but keep innerHTML
                let nodeToRemove = parentSelection.children[nodeIndex];
                let innerContent = parentSelection.children[nodeIndex].innerHTML;
                nodeToRemove.insertAdjacentHTML("beforeBegin", innerContent)
                parentSelection.removeChild(nodeToRemove);
            } else {
                //add surrounding tag
                node.appendChild(selectedTextRange.extractContents());
                selectedTextRange.insertNode(node);
            }
        }
        else {
            let spanNode = document.createElement('span');
            let divNode = document.createElement('div');
            switch (command) {
                case 'textAlign':
                    divNode.style.textAlign = value;
                    divNode.appendChild(selectedTextRange.extractContents());
                    selectedTextRange.insertNode(divNode);
                break;
                case 'fontFamily':
                    spanNode.style.fontFamily = value;
                    spanNode.appendChild(selectedTextRange.extractContents());
                    selectedTextRange.insertNode(spanNode);
                break;
                case 'fontSize':
                    spanNode.style.fontSize = value;
                    spanNode.appendChild(selectedTextRange.extractContents());
                    selectedTextRange.insertNode(spanNode);
                break;
                case 'orderList':
                    spanNode.style.align = value;
                    spanNode.appendChild(selectedTextRange.extractContents());
                    selectedTextRange.insertNode(spanNode);
                break;
                case 'backgroundColor':
                    spanNode.style.backgroundColor = value;
                    spanNode.appendChild(selectedTextRange.extractContents());
                    selectedTextRange.insertNode(spanNode);
                break;
                case 'color':
                    spanNode.style.color = value;
                    spanNode.appendChild(selectedTextRange.extractContents());
                    selectedTextRange.insertNode(spanNode);
                break;
                case 'addLink':
                    let linkNode = document.createElement('a');
                    linkNode.href = value;
                    linkNode.appendChild(selectedTextRange.extractContents());
                    selectedTextRange.insertNode(linkNode);
                break;
                case 'preset':
                    console.log(value.tag);
                    console.log(command);
                    let createdNode = document.createElement(value.tag);
                    createdNode.appendChild(selectedTextRange.extractContents());
                    selectedTextRange.insertNode(createdNode);
                break;                
            }
        }

        //sanitize writingArea html after every modify operation
        sanitizeHTML($refs.writingArea);
    }
    
    //Remove all format
    function eraseAll() {
        const selectedText = window.getSelection();
    
        let el = document.createElement('span');
        el.innerHTML = selectedText.toString();
        let range = selectedText.getRangeAt(0);
        range.deleteContents();
        range.insertNode(el);
    }

    function addLink() {
        let userLink = prompt("Ingresá una URL");
        //if link has http then pass directly else add https
        if (/http/i.test(userLink)) {
            modifyText('addLink', userLink);
        } else {
            userLink = "http://" + userLink;
            modifyText('addLink', userLink);
        }
    }

    function sanitizeHTML(elementToClean) {
        let dirtyElement = elementToClean.innerHTML;
        //clean html element
        let cleanElement = dirtyElement
            .replaceAll("<i></i>", "")
            .replaceAll("<u></u>", "")
            .replaceAll("<s></s>", "")
            .replaceAll("<strong></strong>", "")
            .replaceAll("<h1></h1>", "")
            .replaceAll("<h2></h2>", "")
            .replaceAll("<h3></h3>", "")
            .replaceAll("<span></span>", "");

        //replace
        elementToClean.innerHTML = "";
        elementToClean.innerHTML = cleanElement;
    }

function ref(arg0: string[]): any {
    throw new Error('Function not implemented.');
}
</script>

<style scoped>
    @import '@/assets/styles/textEditor.css';
</style>