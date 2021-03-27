declare type MessageFunction = (d: any) => string;

declare interface CompiledMessages {
  [s: string]: MessageFunction | CompiledMessages;
}

declare let messages: CompiledMessages;
export default messages;
