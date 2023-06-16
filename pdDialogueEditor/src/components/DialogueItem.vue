<template>
  <li class="ma-1 pa-0" :id="`${id}_${itemTitle}`">
<!--    <span class="tf-nc">{{ title }}</span>

    <ul v-if="children">

      <dialogue-item v-for="(dialogue, index) of children"
                     :title="dialogue.id"
                     :text="dialogue.text"
                     :children="dialogue.options"
                     :key="`${title}_child_${index}`"
      >

      </dialogue-item>
    </ul>-->


    <div class="tf-nc pa-0 shrink"
         style="border-radius: 5px; border: 1px white solid;" >
      <v-container class="pa-1"
                   :fluid="true" >

      <!--  clear icon button-->
      <div style="position: absolute; right: -5px; top: -5px; z-index: 10;"
            class="px-1">
        <v-btn class="ma-0"
                 icon="mdi-close"
                 color="red"
                 size="small"
                 density="compact"
                 @click="$emit('clearItem', { id, title: itemTitle })"
        />
      </div>

        <!--  add icon button-->
      <div style="position: absolute; right: -5px; bottom: -5px; z-index: 10;"
           class="pa-1">
        <v-btn icon="mdi-plus-box"
               @click="$emit('addItem', { id, title: itemTitle })"
               size="small"
               density="comfortable" />
      </div>

      <v-row no-gutters
             style="align-items: center;">
        <v-col class="grow pa-0">
<!--
          v-model="itemTitle"
-->
          <v-text-field :model-value="itemTitle"
                        label="Dialogue Title"
                        hide-details
                        density="compact"
                        @blur="itemTitle = $event.target.value"
                        variant="underlined"
                        class="pa-1">
          </v-text-field>
        </v-col>

      </v-row>

      <v-row no-gutters >
        <v-col >
          <v-textarea :model-value="itemText"
                      @blur="itemText = $event.target.value"
                      label="Text"
                      class="pa-1"
                      hide-details
                      density="compact"
                      auto-grow>

          </v-textarea>
        </v-col>
      </v-row>

      <v-row v-if="!children"
             no-gutters
              class="pa-1">
        <v-col >
          <v-text-field :model-value="itemNext"
                        @blur="itemNext = $event.target.value"
                        label="Next Dialogue"
                        density="compact"
                        variant="outlined"
                        hide-details >
          </v-text-field>
        </v-col>
      </v-row>

      </v-container>

    </div>

    <ul >

      <dialogue-item v-if="children"
                     v-for="(dialogue, index) of children"
                     :id="dialogue.id"
                     :title="dialogue.title"
                     :text="dialogue.text"
                     :next="dialogue.next"
                     :children="dialogue.options"
                     :key="`${title}_child_${index}`"
                     @addItem="catchAddItem"
                     @clearItem="catchClearItem"
                     @changeProperty="catchPropertyChange"
      />

    </ul>

  </li>
</template>

<script>
const DialogueItem = import("@/components/DialogueItem.vue")

export default {
  name: 'DialogueItem',
  emits: [
    'addItem',
    'clearItem',
    'changeProperty',
  ],
  props: {
    id: String,
    title: String,
    text: String,
    children: {
      type: Array,
      default: undefined,
    },
    next: String,
  },
  computed: {
    itemTitle: {
      get() {
        return this.title;
      },
      set(value) {
        this.changeProperty('title', this.title, value);
      }
    },
    itemText: {
      get() {
        return this.text;
      },
      set(value) {
        this.changeProperty('text', this.text, value);
      }
    },
    itemNext: {
      get() {
        return this.next;
      },
      set(value) {
        this.changeProperty('next', this.next, value);
      }
    },
  },
  methods: {
    catchAddItem({ id, title }) {
      this.$emit('addItem', { id, title })
    },
    catchClearItem({ id, title }) {
      this.$emit('clearItem', { id, title })
    },
    changeProperty(property, oldValue, newValue) {
      this.catchPropertyChange({
        id: this.id,
        title: this.itemTitle,
        property,
        oldValue,
        newValue,
      });
    },
    catchPropertyChange({ id,
                          title,
                          property,
                          oldValue,
                          newValue,
                        }) {
      this.$emit('changeProperty', {
        id,
        title,
        property,
        oldValue,
        newValue,
      });
    },
  },
  components: {
    DialogueItem,
  },
  data: () => ({
  }),
};

</script>
