<template>
  <div class="mainGrid">
    <div>Navigation?</div>

    <div style="/* height: 700px; width: 100%; */ border: 1px solid white;" >

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

export default {
  mounted() {
  },
  components: {
    DialogueChapter,
    DialogueChapterAdd,
  },
  computed: {
    chapters() {
      return this.dialogueList.chapters[0];
    },
    dialogueList () {
/*
      return this.dialogueTest;
*/

      return {
        "characters": [
          "eddie", "fritz", "monk"
        ],
        "chapters": [
          {
            "name": "act one",
            "dialogues": [
              {
                "id": "questionHash",
                "character": "eddie",
                "text": "What do you think we should do now?",
                "options": [
                  {
                    "id": "nothingHash",
                    "text": "Nothing"
                  },
                  {
                    "id": "shoppingHash",
                    "text": "Go shopping"
                  }
                ]
              },
              {
                "id": "shoppingHash",
                "character": "fritz",
                "text": "Naahh... I don't want to go shopping, I wanna play games!",
                "options": [
                  {
                    "id": "answerNothing",
                    "text": "I want to do nothing",
                    "next": "questionHash"
                  },
                  {
                    "id": "answerChill",
                    "text": "Let's chill!",
                    "next": "chillHash"
                  }
                ]
              },
              /*
                            {
                              "id": "nothingHash",
                              "character": "fritz",
                              "text": "What nothing... But I wanna do something!",
                              "next": "questionHash"
                            },
                            {
                              "id": "chillHash",
                              "character": "monk",
                              "text": "Uuuhhh I did I hear chill? I'm just the dude for it!",
                              "options": [
                              ]
                            }
              */
            ]
          }
        ]
      };

    }
  },
  methods: {
    catchAddItem(parent) {
      console.log('catchAddItem');
      console.log(parent)
    },
    catchAddChapter(parent) {
      console.log('catchAddChapter');
      console.log(parent)
    },
  },
  data: () => ({
/*
    dialogueTest,
*/
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
