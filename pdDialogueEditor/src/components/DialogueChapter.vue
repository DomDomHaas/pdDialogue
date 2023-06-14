<template>
  <div class="pa-0"
       style="display: flex; border: 1px white solid;">

    <div class="ma-2" style="display: flex;">
      <v-text-field :model-value="name"
                    label="Chapter"
                    hide-details
                    density="compact"
                    variant="outlined"
                    class="pa-1">
      </v-text-field>

      <v-btn :icon="expanded ? 'mdi-chevron-down' : 'mdi-chevron-left'"
             density="compact"
             @click="expanded = !expanded" >
      </v-btn>

      <v-btn class="ml-2"
             icon="mdi-plus-box-multiple"
             density="compact"
             @click="$emit('addChapterItem', name)" >
      </v-btn>

    </div>

    <ul v-if="expanded"
        v-for="(dialogue, index) of dialogues"
        :id="`tree_${index}`"
        style="display: flex;"
        class="tf-tree tf-gap-sm">

      <dialogue-item :title="dialogue.id"
                     :text="dialogue.text"
                     :next="dialogue.next"
                     :children="dialogue.options"
                     :key="`tree_${index}`"
                     @addItem="catchAddItem"
      />
    </ul>

  </div>

</template>

<script>
import DialogueItem from "@/components/DialogueItem.vue";
// const DialogueItem = import("@/components/DialogueItem.vue")
export default {
  name: 'DialogueChapter',
  components: { DialogueItem },
  props: {
    name: String,
    dialogues: Array,
  },
  computed: {
  },
  methods: {
    catchAddItem(parent) {
      this.$emit('addItem', parent);
    },
  },
  data: () => ({
    expanded: true,
  }),
};

</script>
