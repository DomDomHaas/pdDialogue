<template>

  <v-container :fluid="true"
                class="pa-4">
    <v-row>
      Navigation?
    </v-row>

    <v-row v-for="(chapter, index) of dialogueList.chapters"
            :key="index" >

      <v-col cols="12">
        <DialogueChapter :name="chapter.name"
                         :dialogues="chapter.dialogues"
                         @addItem="catchAddItem"
                         @addChapterItem="catchAddChapterItem" />
      </v-col>
    </v-row>

    <v-row style="align-items: center;">
      <v-col class="flex-shrink-1 flex-grow-0">
        <v-btn icon="mdi-book-plus"
               @click="catchAddChapter"
               density="comfortable">
        </v-btn>
      </v-col>

      <v-col class="flex-grow-1">
        Add New Chapter
      </v-col>
    </v-row>

  </v-container>

<!--
  <div class="mainGrid">
    <div>Navigation?</div>

    <div style="/* height: 700px; width: 100%; border: 1px solid white; */" >

      <div v-for="(chapter, index) of dialogueList.chapters" >
        <DialogueChapter :name="chapter.name"
                          :dialogues="chapter.dialogues"
                         @addItem="catchAddItem" />
      </div>

    </div>

    <DialogueChapterAdd @addChapter="catchAddChapter" />

  </div>
-->
</template>

<script>
import DialogueChapter from '@/components/DialogueChapter.vue'

import jsonDialogues from './dialogueTest.json';

export default {
  mounted() {
  },
  components: {
    DialogueChapter,
  },
  computed: {
    dialogueList () {
      return this.jsonDialogues;
    }
  },
  methods: {
    catchClearItem(itemTitle) {

    },
    catchAddItem(parent) {
      console.log('catchAddItem');
      const listItem = this.getDialoguItemFromChapters(this.dialogueList.chapters, parent);
      this.addItemOption(listItem);
    },
    catchAddChapter(parent) {
      this.addChapter(this.dialogueList.chapters);
    },
    catchAddChapterItem(chapterName) {
      const chapter = this.dialogueList.chapters.filter((c) => c.name === chapterName)[0] || null;
      if (chapter) {
        this.addDialogue(chapter);
      }
    },
    addChapter(chapterList) {
      if (!chapterList) {
        chapterList = [];
      }

      const newChapter = {
        name: '',
      };

      this.addDialogue(newChapter);
      
      chapterList.push(newChapter)
    },
    addDialogue(chapter) {
      if (!chapter) {
        return;
      }

      if (!chapter.dialogues) {
        chapter.dialogues = [];
      }

      chapter.dialogues.push({
        id: '',
        character: '',
        text: '',
        options: [],
      })
    },
    addItemOption(item) {
      if (!item) {
        return;
      }

      if (!item.options) {
        item.options = [];
      }

      item.options.push({
        id: '',
        text: '',
        next: ''
      })
    },
    getDialoguItemFromChapters(chapters, item) {
      if (!chapters) {
        return null;
      }

      for (let i = 0; i < chapters.length; i++) {
        const chapter = chapters[i];

        const listItem = this.getDialogueItem(chapter.dialogues, item);
        if (listItem) {
          return listItem;
        }
      }

      return null;
    },
    getDialogueItem(list, item) {
      if (!list) {
        return null;
      }

      for (let i = 0; i < list.length; i++) {
        const listItem = list[i];

        if (listItem.id === item) {
          return listItem;
        }

        if (listItem.options?.length > 0) {
          const subItem = this.getDialogueItem(listItem.options, item);
          if (subItem) {
            return subItem;
          }
        }
      }

      return null;
    },
  },
  data: () => ({
    jsonDialogues,
  }),
};
</script>

<style scoped>
/*
.mainGrid {
  height: 90%;
  width: 90%;
  border: 1px solid white;
}
*/

header {
  line-height: 1.5;
}

</style>
