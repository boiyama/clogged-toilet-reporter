import Connect from "aws-sdk/clients/connect";
import console from "./console";

const connect = new Connect({ region: "ap-northeast-1" });

export const handler = async () => {
  const result = await connect
    .startOutboundVoiceContact({
      InstanceId: process.env.INSTANCE_ID as string,
      ContactFlowId: process.env.CONTACT_FLOW_ID as string,
      SourcePhoneNumber: process.env.SOURCE_PHONE_NUMBER as string,
      DestinationPhoneNumber: process.env.DESTINATION_PHONE_NUMBER as string
    })
    .promise();

  console.log(result);

  return result;
};
