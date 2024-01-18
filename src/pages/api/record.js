const { Client } = require("@notionhq/client");

const notion = new Client({
  auth: process.env.NOTION_API_TOKEN,
});

// eslint-disable-next-line import/no-anonymous-default-export
export default async (req, res) => {
  if (req.method !== "POST") {
    return res.status(405).json({ msg: "Only POST requests are allowed" });
  }
  try {
    const { address, amount, hash } = JSON.parse(req.body);
    await notion.pages.create({
      parent: {
        database_id: process.env.NOTION_DATABASE_ID,
      },
      properties: {
        address: {
          title: [
            {
              text: {
                content: address,
              },
            },
          ],
        },
        amount: {
          number: amount,
        },
        hash: {
          url: hash,
        },
      },
    });
    res.status(201).json({ msg: "Success" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ msg: "Failed", error });
  }
};
