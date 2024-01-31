import Image from "next/image";
import React from "react";

const CollectionInfo = () => {
  return (
    <section className=" bg-transparent my-16">
      <div className="container px-6 py-10 mx-auto">
        <div className="lg:-mx-6 lg:flex lg:items-center lg:justify-center lg:gap-6">
          <div className="relative w-full h-96  lg:w-96">
            <Image
              className="object-contain object-center lg:mx-6 rounded-lg lg:h-[36rem]"
              src="/images/itrbl.svg"
              alt="Contributors of IT Rebels"
              objectFit="contain"
              fill={true}
            />
          </div>

          <div className="mt-8 lg:px-6 lg:mt-0">
            <p className="text-5xl font-semibold text-ui-highlight ">“</p>
            <h1 className="text-2xl font-semibold text-ui-white lg:text-3xl lg:w-96">
              Help us improve our productivity
            </h1>
            <p className="max-w-lg mt-6 text-ui-white/60 ">
              “ Lorem ipsum dolor sit amet, consectetur adipisicing elit.
              Tempore quibusdam ducimus libero ad tempora doloribus expedita
              laborum saepe voluptas perferendis delectus assumenda rerum, culpa
              aperiam dolorum, obcaecati corrupti aspernatur a. ”
            </p>
            <h3 className="mt-6 text-lg font-medium text-ui-highlight">
              Mia Brown
            </h3>
            <p className="text-gray-600 dark:text-gray-300">
              Marketing Manager at Stech
            </p>
          </div>
        </div>
      </div>
    </section>
  );
};

export default CollectionInfo;
