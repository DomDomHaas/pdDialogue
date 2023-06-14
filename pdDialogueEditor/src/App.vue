<template>
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
</template>

<script>
import DialogueChapter from '@/components/DialogueChapter.vue'
import DialogueChapterAdd from '@/components/DialogueChapterAdd.vue'

import jsonDialogues from './dialogueTest.json';

export default {
  mounted() {
  },
  components: {
    DialogueChapter,
    DialogueChapterAdd,
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
