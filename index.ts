import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  // Profile을 포함하여 User 생성
  // const userWithProfile = await prisma.user.create({
  //   data: {
  //     profile: {
  //       create: {
  //         name: "국경훈",
  //         email: "user@test.com",
  //       },
  //     },

  //   },
  // });

  const userWithProfile = await prisma.user.update({
    where: {
      idx: 1, // 업데이트할 User의 idx를 지정합니다.
    },
    data: {
      profile: {
        upsert: {
          create: {
            name: "국경훈",
            email: "user@test.com",
          },
          update: {
            name: "국경훈",
            email: "user@test!!.com",
          },
        },
      },
    },
    include: {
      profile: true, // 업데이트 후 Profile을 포함하여 결과를 반환받습니다.
    },
  });

  const userWithPost = await prisma.user.create({
    data: {
      posts: {
        create: {
          title: "제목!!",
          description: "내용!!!!!",
        },
      },
    },
  });
  console.log(userWithProfile);
  console.log(userWithPost);

  // 모든 User 조회
  const users = await prisma.user.findMany({
    include: {
      profile: true, // Profile도 함께 조회
      posts: true, // Post도 함께 조회하려면 true로 설정
      jobs: true, // Job도 함께 조회하려면 true로 설정
      // follower, following 관계는 여기서 생략
    },
  });
  console.log(users);
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
