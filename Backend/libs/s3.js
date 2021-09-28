import { S3Client } from "@aws-sdk/client-s3";
import { getSignedUrl } from "@aws-sdk/s3-request-presigner";
const REGION = "us-east-1";

export const bucketParams = {
    Bucket: process.env.BUCKET_NAME,
    Key: `test-object-${Math.ceil(Math.random() * 10 ** 10)}`,
    Body: "BODY"
};

export async function getSignedUrl() {
    var s3Client = new S3Client({ region: REGION });
    const command = new PutObjectCommand(bucketParams);
    const signedUrl = await getSignedUrl(s3Client, command, {
        expiresIn: 3600,
    });
    return signedUrl;
}